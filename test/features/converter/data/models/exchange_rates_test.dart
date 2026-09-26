import 'package:efg_currency_converter/features/converter/data/models/currency.dart';
import 'package:efg_currency_converter/features/converter/data/models/exchange_rates.dart';
import 'package:efg_currency_converter/features/converter/data/models/rate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExchangeRates.fromRates', () {
    test('maps every quote and keeps the latest rate date', () {
      final rates = ExchangeRates.fromRates(
        base: 'usd',
        rates: [
          Rate(
            date: DateTime(2026, 9, 25),
            base: 'USD',
            quote: 'ALL',
            rate: 80.5,
          ),
          Rate(
            date: DateTime(2026, 9, 26),
            base: 'USD',
            quote: 'EUR',
            rate: 0.85,
          ),
        ],
        updatedAt: DateTime(2026, 9, 26, 14, 5),
      );

      expect(rates.base, 'USD');
      expect(rates.date, DateTime(2026, 9, 26));
      expect(rates.rates, {'ALL': 80.5, 'EUR': 0.85});
      expect(rates.rateFor('USD'), 1);
      expect(rates.rateFor('GBP'), isNull);
    });

    test('throws a FormatException when no rates are returned', () {
      expect(
        () => ExchangeRates.fromRates(
          base: 'USD',
          rates: const [],
          updatedAt: DateTime(2026, 9, 26),
        ),
        throwsFormatException,
      );
    });
  });

  group('Currency.displaySymbol', () {
    test('uses the symbol when the API provides one', () {
      const currency = Currency(code: 'EUR', name: 'Euro', symbol: '€');
      expect(currency.displaySymbol, '€');
    });

    test('falls back to the code when the symbol is missing', () {
      const currency = Currency(code: 'CMD', name: 'Commodity');
      expect(currency.displaySymbol, 'CMD');
    });
  });
}
