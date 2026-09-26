import 'package:efg_currency_converter/core/services/local/cache/caching_data_factory.dart';
import 'package:efg_currency_converter/core/services/local/cache/repository/base_caching_service.dart';
import 'package:efg_currency_converter/core/utils/app_strings.dart';
import 'package:efg_currency_converter/core/utils/enums.dart';
import 'package:efg_currency_converter/features/history/data/models/conversion.dart';
import 'package:efg_currency_converter/features/history/data/repositories/local/local_history_repository.dart';

class LocalHistoryDataSource extends LocalHistoryRepository {
  LocalHistoryDataSource();

  final BaseCacheService _service =
      CachingDataFactory(CachingType.simple).cacheService;

  @override
  Future<List<Conversion>> getConversions() async {
    final result = await _service.readJsonMap(AppStrings.historyKey);
    final conversions = result?['conversions'];
    if (conversions is! List) {
      return [];
    }
    return conversions
        .whereType<Map<String, dynamic>>()
        .map(Conversion.fromJson)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<bool> saveConversion(Conversion conversion) async {
    final conversions = await getConversions();
    final index = conversions.indexWhere((item) => item.id == conversion.id);
    if (index == -1) {
      conversions.add(conversion);
    } else {
      conversions[index] = conversion;
    }
    return _writeConversions(conversions);
  }

  @override
  Future<bool> deleteConversion(String id) async {
    final conversions = await getConversions()
      ..removeWhere((item) => item.id == id);
    return _writeConversions(conversions);
  }

  @override
  Future<bool> clearConversions() async {
    return _service.delete(AppStrings.historyKey);
  }

  Future<bool> _writeConversions(List<Conversion> conversions) async {
    return _service.writeJsonMap(
      AppStrings.historyKey,
      {
        'conversions':
            conversions.map((conversion) => conversion.toJson()).toList(),
      },
    );
  }
}
