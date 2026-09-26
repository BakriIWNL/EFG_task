import 'package:efg_currency_converter/core/services/local/cache/caching_data_factory.dart';
import 'package:efg_currency_converter/core/services/local/cache/repository/base_caching_service.dart';
import 'package:efg_currency_converter/core/utils/app_strings.dart';
import 'package:efg_currency_converter/core/utils/enums.dart';
import 'package:efg_currency_converter/features/converter/data/models/currency.dart';
import 'package:efg_currency_converter/features/converter/data/models/exchange_rates.dart';
import 'package:efg_currency_converter/features/converter/data/repositories/local/local_converter_repository.dart';

class LocalConverterDataSource extends LocalConverterRepository {
  LocalConverterDataSource();

  final BaseCacheService _service =
      CachingDataFactory(CachingType.simple).cacheService;

  @override
  Future<void> cacheCurrencies(List<Currency> currencies) async {
    await _service.writeJsonMap(
      AppStrings.currenciesKey,
      {
        'currencies': currencies.map((currency) => currency.toJson()).toList(),
      },
    );
  }

  @override
  Future<List<Currency>> getCachedCurrencies() async {
    final result = await _service.readJsonMap(AppStrings.currenciesKey);
    final currencies = result?['currencies'];
    if (currencies is List) {
      return currencies
          .whereType<Map<String, dynamic>>()
          .map(Currency.fromJson)
          .toList();
    }
    return [];
  }

  @override
  Future<void> cacheRates(ExchangeRates rates) async {
    final cachedRates = await _service.readJsonMap(AppStrings.ratesKey) ?? {};
    await _service.writeJsonMap(
      AppStrings.ratesKey,
      {
        ...cachedRates,
        rates.base: rates.toJson(),
      },
    );
  }

  @override
  Future<Map<String, ExchangeRates>> getCachedRates() async {
    final result = await _service.readJsonMap(AppStrings.ratesKey) ?? {};
    return {
      for (final entry in result.entries)
        if (entry.value is Map<String, dynamic>)
          entry.key: ExchangeRates.fromJson(
            entry.value as Map<String, dynamic>,
          ),
    };
  }
}
