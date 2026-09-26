import 'package:efg_currency_converter/features/converter/data/models/currency.dart';
import 'package:efg_currency_converter/features/converter/data/models/exchange_rates.dart';

abstract class LocalConverterRepository {
  Future<void> cacheCurrencies(List<Currency> currencies);

  Future<List<Currency>> getCachedCurrencies();

  Future<void> cacheRates(ExchangeRates rates);

  Future<Map<String, ExchangeRates>> getCachedRates();
}
