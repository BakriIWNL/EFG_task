import 'dart:async';
import 'dart:convert';

import 'package:efg_currency_converter/core/services/local/cache/caching_data_factory.dart';
import 'package:efg_currency_converter/core/services/local/cache/repository/base_caching_service.dart';
import 'package:efg_currency_converter/core/utils/typedef.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SimpleCachingService extends CachingDataFactory with BaseCacheService {
  SimpleCachingService() : super.init();

  Future<SharedPreferences> get _pref async => SharedPreferences.getInstance();

  Future<bool> _write(
    Future<bool> Function(SharedPreferences sharedPreference) write,
  ) async {
    try {
      final sharedPreference = await _pref;
      return await write(sharedPreference);
    } on Object {
      return false;
    }
  }

  @override
  FutureOr<bool> delete(String key) async {
    return _write((sharedPreference) => sharedPreference.remove(key));
  }

  @override
  Future<String?> readString(String key) async {
    final sharedPreference = await _pref;
    return sharedPreference.getString(key);
  }

  @override
  Future<int?> readInt(String key) async {
    final sharedPreference = await _pref;
    return sharedPreference.getInt(key);
  }

  @override
  Future<bool?> readBool(String key) async {
    final sharedPreference = await _pref;
    return sharedPreference.getBool(key);
  }

  @override
  Future<JsonMap?> readJsonMap(String key) async {
    final sharedPreference = await _pref;
    final data = sharedPreference.getString(key);
    if (data == null) return null;
    try {
      return jsonDecode(data) as JsonMap;
    } on Object {
      return null;
    }
  }

  @override
  FutureOr<bool> writeInt(String key, int value) async {
    return _write(
      (sharedPreference) => sharedPreference.setInt(key, value),
    );
  }

  @override
  FutureOr<bool> writeString(String key, String value) async {
    return _write(
      (sharedPreference) => sharedPreference.setString(key, value),
    );
  }

  @override
  FutureOr<bool> writeJsonMap(String key, JsonMap value) async {
    return _write(
      (sharedPreference) =>
          sharedPreference.setString(key, jsonEncode(value)),
    );
  }

  @override
  Future<bool> containKey(String key) async {
    final sharedPreference = await _pref;
    return sharedPreference.containsKey(key);
  }

  @override
  FutureOr<bool> writeBool({required String key, required bool value}) async {
    return _write(
      (sharedPreference) => sharedPreference.setBool(key, value),
    );
  }

  @override
  BaseCacheService get cacheService => SimpleCachingService();
}
