import 'package:efg_currency_converter/features/history/data/models/conversion.dart';

abstract class LocalHistoryRepository {
  Future<List<Conversion>> getConversions();

  Future<bool> saveConversion(Conversion conversion);

  Future<bool> deleteConversion(String id);

  Future<bool> clearConversions();
}
