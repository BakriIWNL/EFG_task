import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:efg_currency_converter/core/error/failure.dart';
import 'package:efg_currency_converter/core/utils/enums.dart';
import 'package:efg_currency_converter/features/converter/data/models/exchange_rates.dart';
import 'package:efg_currency_converter/features/converter/data/repositories/local/local_converter_repository.dart';
import 'package:efg_currency_converter/features/converter/data/repositories/remote/converter_repository.dart';
import 'package:efg_currency_converter/features/history/data/models/conversion.dart';
import 'package:efg_currency_converter/features/history/data/repositories/local/local_history_repository.dart';
import 'package:efg_currency_converter/features/history/presentation/controllers/history_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConverterRepository extends Mock implements ConverterRepository {}

class MockLocalConverterRepository extends Mock
    implements LocalConverterRepository {}

class MockLocalHistoryRepository extends Mock
    implements LocalHistoryRepository {}

void main() {
  late MockConverterRepository mockRepository;
  late MockLocalConverterRepository mockLocalRepository;
  late MockLocalHistoryRepository mockLocalHistoryRepository;

  final tOutdatedConversion = Conversion(
    id: '1',
    amount: 10,
    fromCode: 'USD',
    toCode: 'EUR',
    fromSymbol: r'$',
    toSymbol: '€',
    rate: 0.4,
    convertedAmount: 4,
    rateDate: DateTime(2026, 9, 20),
    updatedAt: DateTime(2026, 9, 20, 9, 30),
    createdAt: DateTime(2026, 9, 25, 10),
    isOutdated: true,
  );

  final tFreshRates = ExchangeRates(
    base: 'USD',
    date: DateTime(2026, 9, 26),
    rates: const {'EUR': 0.5},
    updatedAt: DateTime(2026, 9, 26, 12),
  );

  final tNewerCachedRates = ExchangeRates(
    base: 'USD',
    date: DateTime(2026, 9, 25),
    rates: const {'EUR': 0.45},
    updatedAt: DateTime(2026, 9, 25, 18, 45),
  );

  const tFailure = NetworkFailure(
    message: 'Connection error',
    statusCode: 0,
  );

  final tLoadedState = HistoryState(
    state: GenericStates.success,
    conversions: [tOutdatedConversion],
  );

  setUpAll(() {
    registerFallbackValue(tFreshRates);
    registerFallbackValue(tOutdatedConversion);
  });

  setUp(() {
    mockRepository = MockConverterRepository();
    mockLocalRepository = MockLocalConverterRepository();
    mockLocalHistoryRepository = MockLocalHistoryRepository();
    when(() => mockLocalRepository.cacheRates(any())).thenAnswer((_) async {});
    when(() => mockLocalRepository.getCachedRates())
        .thenAnswer((_) async => {});
    when(() => mockLocalHistoryRepository.saveConversion(any()))
        .thenAnswer((_) async => true);
  });

  HistoryCubit buildCubit() => HistoryCubit(
        mockRepository,
        mockLocalRepository,
        mockLocalHistoryRepository,
      );

  group('HistoryCubit', () {
    blocTest<HistoryCubit, HistoryState>(
      'emits [loading, success] when getHistory is called',
      build: () {
        when(() => mockLocalHistoryRepository.getConversions())
            .thenAnswer((_) async => [tOutdatedConversion]);
        return buildCubit();
      },
      act: (cubit) => cubit.getHistory(),
      expect: () => [
        const HistoryState(state: GenericStates.loading),
        tLoadedState,
      ],
    );

    blocTest<HistoryCubit, HistoryState>(
      'removes the outdated tag and caches the rates when recalculation '
      'succeeds',
      build: () {
        when(() => mockRepository.getRates('USD'))
            .thenAnswer((_) async => Right(tFreshRates));
        return buildCubit();
      },
      seed: () => tLoadedState,
      act: (cubit) => cubit.recalculate(tOutdatedConversion),
      expect: () {
        final recalculated = tOutdatedConversion.recalculate(
          rates: tFreshRates,
          isOutdated: false,
        );
        return [
          tLoadedState.copyWith(
            recalculatingIds: ['1'],
            recalculateState: GenericStates.loading,
          ),
          tLoadedState.copyWith(
            conversions: [recalculated],
            recalculatingIds: [],
            recalculateState: GenericStates.success,
            recalculatedConversion: recalculated,
          ),
        ];
      },
      verify: (cubit) {
        final conversion = cubit.state.conversions.single;
        expect(conversion.isOutdated, isFalse);
        expect(conversion.rate, 0.5);
        expect(conversion.convertedAmount, 5);
        expect(conversion.updatedAt, tFreshRates.updatedAt);
        verify(() => mockLocalRepository.cacheRates(tFreshRates)).called(1);
      },
    );

    blocTest<HistoryCubit, HistoryState>(
      'keeps the outdated tag and updates the last updated date from the '
      'saved rates when recalculation fails',
      build: () {
        when(() => mockRepository.getRates('USD'))
            .thenAnswer((_) async => const Left(tFailure));
        when(() => mockLocalRepository.getCachedRates())
            .thenAnswer((_) async => {'USD': tNewerCachedRates});
        return buildCubit();
      },
      seed: () => tLoadedState,
      act: (cubit) => cubit.recalculate(tOutdatedConversion),
      skip: 1,
      expect: () => [
        isA<HistoryState>()
            .having(
              (state) => state.recalculateState,
              'recalculateState',
              GenericStates.success,
            )
            .having(
              (state) => state.recalculatingIds,
              'recalculatingIds',
              isEmpty,
            ),
      ],
      verify: (cubit) {
        final conversion = cubit.state.conversions.single;
        expect(conversion.isOutdated, isTrue);
        expect(conversion.updatedAt, tNewerCachedRates.updatedAt);
        expect(conversion.convertedAmount, 4.5);
        verifyNever(() => mockLocalRepository.cacheRates(any()));
      },
    );

    blocTest<HistoryCubit, HistoryState>(
      'emits error and leaves the conversion unchanged when recalculation '
      'fails and nothing is saved',
      build: () {
        when(() => mockRepository.getRates('USD'))
            .thenAnswer((_) async => const Left(tFailure));
        return buildCubit();
      },
      seed: () => tLoadedState,
      act: (cubit) => cubit.recalculate(tOutdatedConversion),
      expect: () => [
        tLoadedState.copyWith(
          recalculatingIds: ['1'],
          recalculateState: GenericStates.loading,
        ),
        tLoadedState.copyWith(
          recalculatingIds: [],
          recalculateState: GenericStates.error,
          errorMessage: 'Connection error',
        ),
      ],
      verify: (_) {
        verifyNever(() => mockLocalHistoryRepository.saveConversion(any()));
      },
    );

    blocTest<HistoryCubit, HistoryState>(
      'removes the conversion when deleteConversion succeeds',
      build: () {
        when(() => mockLocalHistoryRepository.deleteConversion('1'))
            .thenAnswer((_) async => true);
        return buildCubit();
      },
      seed: () => tLoadedState,
      act: (cubit) => cubit.deleteConversion(tOutdatedConversion),
      expect: () => [
        tLoadedState.copyWith(
          conversions: [],
          deleteState: GenericStates.loading,
        ),
        tLoadedState.copyWith(
          conversions: [],
          deleteState: GenericStates.success,
          deletedConversion: tOutdatedConversion,
        ),
      ],
    );

    blocTest<HistoryCubit, HistoryState>(
      'restores the conversions when clearHistory fails',
      build: () {
        when(() => mockLocalHistoryRepository.clearConversions())
            .thenAnswer((_) async => false);
        return buildCubit();
      },
      seed: () => tLoadedState,
      act: (cubit) => cubit.clearHistory(),
      expect: () => [
        tLoadedState.copyWith(
          conversions: [],
          clearState: GenericStates.loading,
        ),
        tLoadedState.copyWith(clearState: GenericStates.error),
      ],
    );
  });
}
