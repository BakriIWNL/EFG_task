import 'package:efg_currency_converter/config/localizations/app_localizations.dart';
import 'package:efg_currency_converter/config/themes/flavors/flavors.dart';
import 'package:efg_currency_converter/features/converter/presentation/screens/converter_screen.dart';
import 'package:efg_currency_converter/features/history/data/models/conversion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tConversion = Conversion(
    id: '1',
    amount: 10,
    fromCode: 'USD',
    toCode: 'EUR',
    fromSymbol: r'$',
    toSymbol: '€',
    rate: 0.5,
    convertedAmount: 5,
    rateDate: DateTime(2026, 9, 26),
    updatedAt: DateTime(2026, 9, 25, 14, 5),
    createdAt: DateTime(2026, 9, 26, 9),
  );

  Widget buildApp(Widget child) {
    return Builder(
      builder: (context) => MaterialApp(
        theme: LightTheme().createThemeData(context),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: child),
      ),
    );
  }

  group('BuildRatesDate', () {
    testWidgets('shows the rate date without a time for fresh rates',
        (tester) async {
      await tester.pumpWidget(
        buildApp(BuildRatesDate(conversion: tConversion, color: Colors.black)),
      );

      final text = tester.widget<Text>(find.text('Rates as of 26 Sep 2026'));
      expect(text.style?.color, Colors.black);
    });

    testWidgets('highlights the last update date and time in red when outdated',
        (tester) async {
      await tester.pumpWidget(
        buildApp(
          BuildRatesDate(
            conversion: tConversion.copyWith(isOutdated: true),
            color: Colors.black,
          ),
        ),
      );

      final context = tester.element(find.byType(BuildRatesDate));
      final text = tester.widget<Text>(
        find.text('Rates as of 25 Sep 2026, 14:05'),
      );
      expect(text.style?.color, Theme.of(context).colorScheme.error);
    });
  });
}
