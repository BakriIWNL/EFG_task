import 'dart:async';

import 'package:efg_currency_converter/core/utils/typedef.dart';

mixin BaseCacheService {
  Future<bool> containKey(String key);

  Future<String?> readString(String key);

  Future<int?> readInt(String key);

  Future<bool?> readBool(String key);

  Future<JsonMap?> readJsonMap(String key);

  FutureOr<bool> writeString(String key, String value);

  FutureOr<bool> writeInt(String key, int value);

  FutureOr<bool> writeBool({
    required String key,
    required bool value,
  });

  FutureOr<bool> writeJsonMap(String key, JsonMap value);

  FutureOr<bool> delete(String key);
}
