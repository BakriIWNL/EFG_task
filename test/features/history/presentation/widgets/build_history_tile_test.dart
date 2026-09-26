import 'package:dartz/dartz.dart';
import 'package:efg_currency_converter/config/localizations/app_localizations.dart';
import 'package:efg_currency_converter/config/themes/flavors/flavors.dart';
import 'package:efg_currency_converter/core/components/custom_list_tile.dart';
import 'package:efg_currency_converter/features/converter/data/models/exchange_rates.dart';
import 'package:efg_currency_converter/features/converter/data/repositories/local/local_converter_repository.dart';
import 'package:efg_currency_converter/features/converter/data/repositories/remote/converter_repository.dart';
import 'package:efg_currency_converter/features/history/data/models/conversion.dart';
import 'package:efg_currency_converter/features/history/data/repositories/local/local_history_repository.dart';
import 'package:efg_currency_converter/features/history/presentation/controllers/history_cubit.dart';
import 'package:efg_currency_converter/features/history/presentation/screens/history_screen.dart';
import 'package:efg_currency_converter/shared/widgets/convert_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late HistoryCubit historyCubit;

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
    updatedAt: DateTime(2026, 9, 26, 12, 15),
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
    historyCubit = HistoryCubit(
      mockRepository,
      mockLocalRepository,
      mockLocalHistoryRepository,
    );
  });

  tearDown(() => historyCubit.close());

  Future<void> pumpHistory(
    WidgetTester tester,
    List<Conversion> conversions,
  ) async {
    when(() => mockLocalHistoryRepository.getConversions())
        .thenAnswer((_) async => conversions);
    await historyCubit.getHistory();
    await tester.pumpWidget(
      BlocProvider.value(
        value: historyCubit,
        child: Builder(
          builder: (context) => MaterialApp(
            theme: LightTheme().createThemeData(context),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: BlocBuilder<HistoryCubit, HistoryState>(
                builder: (context, state) => BuildHistoryTile(
                  conversion: state.conversions.single,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('BuildHistoryTile', () {
    testWidgets('uses the shared list tile and convert button',
        (tester) async {
      await pumpHistory(tester, [tOutdatedConversion]);

      expect(find.byType(CustomListTile), findsOneWidget);
      expect(find.widgetWithText(ConvertButton, 'Recalculate'), findsOneWidget);
    });

    testWidgets('hides the outdated tag for rates that were fresh',
        (tester) async {
      await pumpHistory(
        tester,
        [tOutdatedConversion.copyWith(isOutdated: false)],
      );

      expect(find.text('Outdated'), findsNothing);
      expect(find.text('Rates updated 20 Sep 2026, 09:30'), findsOneWidget);
    });

    testWidgets('shows the outdated tag and a red last update time',
        (tester) async {
      await pumpHistory(tester, [tOutdatedConversion]);

      expect(find.text('Outdated'), findsOneWidget);
      final context = tester.element(find.byType(BuildHistoryTile));
      final style = DefaultTextStyle.of(
        tester.element(find.text('Rates updated 20 Sep 2026, 09:30')),
      ).style;
      expect(style.color, Theme.of(context).colorScheme.error);
    });

    testWidgets(
        'removes the tag and updates the time after a successful recalculation',
        (tester) async {
      when(() => mockRepository.getRates('USD'))
          .thenAnswer((_) async => Right(tFreshRates));
      await pumpHistory(tester, [tOutdatedConversion]);

      await tester.tap(find.text('Recalculate'));
      await tester.pumpAndSettle();

      expect(find.text('Outdated'), findsNothing);
      expect(find.text('Rates updated 26 Sep 2026, 12:15'), findsOneWidget);
      expect(find.text('€5.00'), findsOneWidget);
    });
  });
}
