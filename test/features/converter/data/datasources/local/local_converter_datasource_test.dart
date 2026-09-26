import 'package:efg_currency_converter/features/converter/data/datasources/local/local_converter_datasource.dart';
import 'package:efg_currency_converter/features/converter/data/models/currency.dart';
import 'package:efg_currency_converter/features/converter/data/models/exchange_rates.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late LocalConverterDataSource dataSource;

  final tUsdRates = ExchangeRates(
    base: 'USD',
    date: DateTime(2026, 9, 26),
    rates: const {'EUR': 0.5, 'GBP': 0.8},
    updatedAt: DateTime(2026, 9, 26, 12, 5),
  );

  final tEurRates = ExchangeRates(
    base: 'EUR',
    date: DateTime(2026, 9, 26),
    rates: const {'USD': 2},
    updatedAt: DateTime(2026, 9, 26, 13, 10),
  );

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    dataSource = LocalConverterDataSource();
  });

  group('LocalConverterDataSource', () {
    test('returns empty collections when nothing is saved', () async {
      expect(await dataSource.getCachedCurrencies(), isEmpty);
      expect(await dataSource.getCachedRates(), isEmpty);
    });

    test('saves and reads the currencies', () async {
      const currencies = [
        Currency(code: 'EUR', name: 'Euro', symbol: '€'),
        Currency(code: 'CMD', name: 'Commodity'),
      ];

      await dataSource.cacheCurrencies(currencies);

      expect(await dataSource.getCachedCurrencies(), currencies);
    });

    test('keeps every base currency and its last update time', () async {
      await dataSource.cacheRates(tUsdRates);
      await dataSource.cacheRates(tEurRates);

      final cachedRates = await dataSource.getCachedRates();

      expect(cachedRates, {'USD': tUsdRates, 'EUR': tEurRates});
      expect(cachedRates['USD']?.updatedAt, DateTime(2026, 9, 26, 12, 5));
    });

    test('replaces the saved rates of the same base currency', () async {
      final newerUsdRates = ExchangeRates(
        base: 'USD',
        date: DateTime(2026, 9, 27),
        rates: const {'EUR': 0.55},
        updatedAt: DateTime(2026, 9, 27, 8),
      );

      await dataSource.cacheRates(tUsdRates);
      await dataSource.cacheRates(newerUsdRates);

      expect(await dataSource.getCachedRates(), {'USD': newerUsdRates});
    });
  });
}
