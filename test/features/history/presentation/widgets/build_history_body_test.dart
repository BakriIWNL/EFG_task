import 'package:efg_currency_converter/config/localizations/app_localizations.dart';
import 'package:efg_currency_converter/config/themes/flavors/flavors.dart';
import 'package:efg_currency_converter/core/controllers/network_cubit.dart';
import 'package:efg_currency_converter/features/converter/data/repositories/local/local_converter_repository.dart';
import 'package:efg_currency_converter/features/converter/data/repositories/remote/converter_repository.dart';
import 'package:efg_currency_converter/features/history/data/models/conversion.dart';
import 'package:efg_currency_converter/features/history/data/repositories/local/local_history_repository.dart';
import 'package:efg_currency_converter/features/history/presentation/controllers/history_cubit.dart';
import 'package:efg_currency_converter/features/history/presentation/screens/history_screen.dart';
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
  late MockLocalHistoryRepository mockLocalHistoryRepository;
  late HistoryCubit historyCubit;
  late NetworkCubit networkCubit;
  late List<Conversion> tStoredConversions;

  Conversion buildConversion(String id, double convertedAmount, int hour) {
    return Conversion(
      id: id,
      amount: 10,
      fromCode: 'USD',
      toCode: 'EUR',
      fromSymbol: r'$',
      toSymbol: '€',
      rate: convertedAmount / 10,
      convertedAmount: convertedAmount,
      rateDate: DateTime(2026, 9, 26),
      updatedAt: DateTime(2026, 9, 26, hour),
      createdAt: DateTime(2026, 9, 26, hour),
    );
  }

  final tFirstConversion = buildConversion('1', 8, 12);
  final tSecondConversion = buildConversion('2', 9, 11);

  setUpAll(() {
    registerFallbackValue(tFirstConversion);
  });

  setUp(() {
    tStoredConversions = [tFirstConversion, tSecondConversion];
    mockLocalHistoryRepository = MockLocalHistoryRepository();
    when(() => mockLocalHistoryRepository.getConversions())
        .thenAnswer((_) async => [...tStoredConversions]);
    when(() => mockLocalHistoryRepository.deleteConversion(any()))
        .thenAnswer((invocation) async {
      final id = invocation.positionalArguments.first as String;
      tStoredConversions.removeWhere((item) => item.id == id);
      return true;
    });
    when(() => mockLocalHistoryRepository.saveConversion(any()))
        .thenAnswer((invocation) async {
      tStoredConversions.add(
        invocation.positionalArguments.first as Conversion,
      );
      return true;
    });
    historyCubit = HistoryCubit(
      MockConverterRepository(),
      MockLocalConverterRepository(),
      mockLocalHistoryRepository,
    );
    networkCubit = NetworkCubit();
  });

  tearDown(() async {
    await historyCubit.close();
    await networkCubit.close();
  });

  Future<void> pumpHistory(WidgetTester tester) async {
    await historyCubit.getHistory();
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: historyCubit),
          BlocProvider.value(value: networkCubit),
        ],
        child: Builder(
          builder: (context) => MaterialApp(
            theme: LightTheme().createThemeData(context),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const HistoryScreen(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('BuildHistoryBody', () {
    testWidgets('removes a swiped entry and offers to undo it',
        (tester) async {
      await pumpHistory(tester);
      expect(find.byType(BuildHistoryTile), findsNWidgets(2));

      await tester.drag(find.text('€8.00'), const Offset(-600, 0));
      await tester.pumpAndSettle();

      expect(find.byType(BuildHistoryTile), findsOneWidget);
      expect(find.text('€8.00'), findsNothing);
      expect(find.text('Conversion deleted.'), findsOneWidget);
      verify(() => mockLocalHistoryRepository.deleteConversion('1')).called(1);
    });

    testWidgets('restores the entry when undo is tapped', (tester) async {
      await pumpHistory(tester);

      await tester.drag(find.text('€8.00'), const Offset(-600, 0));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();

      expect(find.byType(BuildHistoryTile), findsNWidgets(2));
      expect(find.text('€8.00'), findsOneWidget);
    });
  });
}
