import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:efg_currency_converter/core/error/failure.dart';
import 'package:efg_currency_converter/core/utils/enums.dart';
import 'package:efg_currency_converter/features/converter/data/models/currency.dart';
import 'package:efg_currency_converter/features/converter/data/models/exchange_rates.dart';
import 'package:efg_currency_converter/features/converter/data/repositories/local/local_converter_repository.dart';
import 'package:efg_currency_converter/features/converter/data/repositories/remote/converter_repository.dart';
import 'package:efg_currency_converter/features/converter/presentation/controllers/converter_cubit.dart';
import 'package:efg_currency_converter/features/history/data/models/conversion.dart';
import 'package:efg_currency_converter/features/history/data/repositories/local/local_history_repository.dart';
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

  const tCurrencies = [
    Currency(code: 'EUR', name: 'Euro', symbol: '€'),
    Currency(code: 'GBP', name: 'British Pound', symbol: '£'),
    Currency(code: 'USD', name: 'United States Dollar', symbol: r'$'),
  ];

  final tFreshRates = ExchangeRates(
    base: 'USD',
    date: DateTime(2026, 9, 26),
    rates: const {'EUR': 0.5, 'GBP': 0.8},
    updatedAt: DateTime(2026, 9, 26, 12),
  );

  final tCachedRates = ExchangeRates(
    base: 'USD',
    date: DateTime(2026, 9, 20),
    rates: const {'EUR': 0.4},
    updatedAt: DateTime(2026, 9, 20, 9, 30),
  );

  const tFailure = NetworkFailure(
    message: 'Connection error',
    statusCode: 0,
  );

  const tReadyState = ConverterState(
    currenciesState: GenericStates.success,
    currencies: tCurrencies,
    fromCode: 'USD',
    toCode: 'EUR',
  );

  setUpAll(() {
    registerFallbackValue(tFreshRates);
    registerFallbackValue(<Currency>[]);
    registerFallbackValue(
      Conversion.fromRates(
        amount: 1,
        fromCode: 'USD',
        toCode: 'EUR',
        fromSymbol: r'$',
        toSymbol: '€',
        rates: tFreshRates,
        createdAt: DateTime(2026, 9, 26),
        isOutdated: false,
      ),
    );
  });

  setUp(() {
    mockRepository = MockConverterRepository();
    mockLocalRepository = MockLocalConverterRepository();
    mockLocalHistoryRepository = MockLocalHistoryRepository();
    when(() => mockLocalRepository.cacheCurrencies(any()))
        .thenAnswer((_) async {});
    when(() => mockLocalRepository.cacheRates(any())).thenAnswer((_) async {});
    when(() => mockLocalRepository.getCachedRates())
        .thenAnswer((_) async => {});
    when(() => mockLocalHistoryRepository.saveConversion(any()))
        .thenAnswer((_) async => true);
  });

  ConverterCubit buildCubit() => ConverterCubit(
        mockRepository,
        mockLocalRepository,
        mockLocalHistoryRepository,
      );

  group('ConverterCubit', () {
    test('initial state is ConverterState', () {
      final cubit = buildCubit();
      expect(cubit.state, const ConverterState());
      cubit.close();
    });

    blocTest<ConverterCubit, ConverterState>(
      'emits [loading, success] and caches currencies when getCurrencies '
      'succeeds',
      build: () {
        when(() => mockRepository.getCurrencies())
            .thenAnswer((_) async => const Right(tCurrencies));
        return buildCubit();
      },
      act: (cubit) => cubit.getCurrencies(),
      expect: () => [
        const ConverterState(currenciesState: GenericStates.loading),
        tReadyState,
      ],
      verify: (_) {
        verify(() => mockLocalRepository.cacheCurrencies(tCurrencies))
            .called(1);
      },
    );

    blocTest<ConverterCubit, ConverterState>(
      'falls back to the cached currencies when getCurrencies fails',
      build: () {
        when(() => mockRepository.getCurrencies())
            .thenAnswer((_) async => const Left(tFailure));
        when(() => mockLocalRepository.getCachedCurrencies())
            .thenAnswer((_) async => tCurrencies);
        return buildCubit();
      },
      act: (cubit) => cubit.getCurrencies(),
      expect: () => [
        const ConverterState(currenciesState: GenericStates.loading),
        tReadyState,
      ],
      verify: (_) {
        verifyNever(() => mockLocalRepository.cacheCurrencies(any()));
      },
    );

    blocTest<ConverterCubit, ConverterState>(
      'emits [loading, error] when getCurrencies fails and nothing is cached',
      build: () {
        when(() => mockRepository.getCurrencies())
            .thenAnswer((_) async => const Left(tFailure));
        when(() => mockLocalRepository.getCachedCurrencies())
            .thenAnswer((_) async => []);
        return buildCubit();
      },
      act: (cubit) => cubit.getCurrencies(),
      expect: () => [
        const ConverterState(currenciesState: GenericStates.loading),
        const ConverterState(
          currenciesState: GenericStates.error,
          errorMessage: 'Connection error',
        ),
      ],
    );

    blocTest<ConverterCubit, ConverterState>(
      'caches the fresh rates and saves an up to date conversion when '
      'getRates succeeds',
      build: () {
        when(() => mockRepository.getRates('USD'))
            .thenAnswer((_) async => Right(tFreshRates));
        return buildCubit();
      },
      seed: () => tReadyState,
      act: (cubit) => cubit.convertAmount(10),
      expect: () => [
        tReadyState.copyWith(conversionState: GenericStates.loading),
        tReadyState.copyWith(
          conversionState: GenericStates.loading,
          cachedRates: {'USD': tFreshRates},
        ),
        isA<ConverterState>()
            .having(
              (state) => state.conversionState,
              'conversionState',
              GenericStates.success,
            )
            .having(
              (state) => state.saveConversionState,
              'saveConversionState',
              GenericStates.success,
            )
            .having(
              (state) => state.conversion?.convertedAmount,
              'convertedAmount',
              5,
            )
            .having(
              (state) => state.conversion?.isOutdated,
              'isOutdated',
              false,
            )
            .having(
              (state) => state.conversion?.fromSymbol,
              'fromSymbol',
              r'$',
            )
            .having(
              (state) => state.conversion?.toSymbol,
              'toSymbol',
              '€',
            ),
      ],
      verify: (_) {
        verify(() => mockLocalRepository.cacheRates(tFreshRates)).called(1);
        verify(() => mockLocalHistoryRepository.saveConversion(any()))
            .called(1);
      },
    );

    blocTest<ConverterCubit, ConverterState>(
      'uses the cached rates and marks the conversion outdated when getRates '
      'fails',
      build: () {
        when(() => mockRepository.getRates('USD'))
            .thenAnswer((_) async => const Left(tFailure));
        when(() => mockLocalRepository.getCachedRates())
            .thenAnswer((_) async => {'USD': tCachedRates});
        return buildCubit();
      },
      seed: () => tReadyState,
      act: (cubit) => cubit.convertAmount(10),
      expect: () => [
        tReadyState.copyWith(conversionState: GenericStates.loading),
        isA<ConverterState>()
            .having(
              (state) => state.conversionState,
              'conversionState',
              GenericStates.success,
            )
            .having(
              (state) => state.conversion?.convertedAmount,
              'convertedAmount',
              4,
            )
            .having(
              (state) => state.conversion?.isOutdated,
              'isOutdated',
              true,
            )
            .having(
              (state) => state.conversion?.updatedAt,
              'updatedAt',
              tCachedRates.updatedAt,
            ),
      ],
      verify: (_) {
        verifyNever(() => mockLocalRepository.cacheRates(any()));
      },
    );

    blocTest<ConverterCubit, ConverterState>(
      'emits error when getRates fails and the pair is not cached',
      build: () {
        when(() => mockRepository.getRates('USD'))
            .thenAnswer((_) async => const Left(tFailure));
        return buildCubit();
      },
      seed: () => tReadyState,
      act: (cubit) => cubit.convertAmount(10),
      expect: () => [
        tReadyState.copyWith(conversionState: GenericStates.loading),
        tReadyState.copyWith(
          conversionState: GenericStates.error,
          errorMessage: 'Connection error',
        ),
      ],
      verify: (_) {
        verifyNever(() => mockLocalHistoryRepository.saveConversion(any()));
      },
    );

    blocTest<ConverterCubit, ConverterState>(
      'reports a failed history save while still showing the conversion',
      build: () {
        when(() => mockRepository.getRates('USD'))
            .thenAnswer((_) async => Right(tFreshRates));
        when(() => mockLocalHistoryRepository.saveConversion(any()))
            .thenAnswer((_) async => false);
        return buildCubit();
      },
      seed: () => tReadyState,
      act: (cubit) => cubit.convertAmount(10),
      skip: 2,
      expect: () => [
        isA<ConverterState>()
            .having(
              (state) => state.conversionState,
              'conversionState',
              GenericStates.success,
            )
            .having(
              (state) => state.saveConversionState,
              'saveConversionState',
              GenericStates.error,
            ),
      ],
    );

    blocTest<ConverterCubit, ConverterState>(
      'limits the currencies to the saved rates when connectivity is lost',
      build: () {
        when(() => mockLocalRepository.getCachedRates())
            .thenAnswer((_) async => {'USD': tCachedRates});
        return buildCubit();
      },
      seed: () => tReadyState.copyWith(fromCode: 'GBP'),
      act: (cubit) => cubit.changeConnectivity(InternetState.offState),
      expect: () => [
        tReadyState.copyWith(fromCode: 'GBP', isOffline: true),
        isA<ConverterState>()
            .having((state) => state.isOffline, 'isOffline', true)
            .having((state) => state.fromCode, 'fromCode', 'USD')
            .having((state) => state.toCode, 'toCode', 'EUR')
            .having(
              (state) => state.fromCurrencies.map((c) => c.code).toList(),
              'fromCurrencies',
              ['USD'],
            )
            .having(
              (state) => state.toCurrencies.map((c) => c.code).toList(),
              'toCurrencies',
              ['EUR'],
            ),
      ],
    );

    blocTest<ConverterCubit, ConverterState>(
      'shows every currency again when connectivity comes back',
      build: buildCubit,
      seed: () => tReadyState.copyWith(
        isOffline: true,
        cachedRates: {'USD': tCachedRates},
      ),
      act: (cubit) => cubit.changeConnectivity(InternetState.onState),
      expect: () => [
        isA<ConverterState>()
            .having((state) => state.isOffline, 'isOffline', false)
            .having(
              (state) => state.fromCurrencies.length,
              'fromCurrencies',
              tCurrencies.length,
            ),
      ],
    );

    blocTest<ConverterCubit, ConverterState>(
      'swaps the pair when the target currency is chosen as the source',
      build: buildCubit,
      seed: () => tReadyState,
      act: (cubit) => cubit.selectFrom('EUR'),
      expect: () => [
        tReadyState.copyWith(fromCode: 'EUR', toCode: 'USD'),
      ],
    );

    blocTest<ConverterCubit, ConverterState>(
      'does not swap offline when the reverse pair is not saved',
      build: buildCubit,
      seed: () => tReadyState.copyWith(
        isOffline: true,
        cachedRates: {'USD': tCachedRates},
      ),
      act: (cubit) => cubit.swap(),
      expect: () => <ConverterState>[],
    );
  });
}
