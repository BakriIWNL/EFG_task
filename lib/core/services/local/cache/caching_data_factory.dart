import 'package:efg_currency_converter/core/services/local/cache/datasource/simple_caching_service.dart';
import 'package:efg_currency_converter/core/services/local/cache/repository/base_caching_service.dart';
import 'package:efg_currency_converter/core/utils/enums.dart';
import 'package:flutter/foundation.dart';

abstract class CachingDataFactory {
  factory CachingDataFactory(CachingType cachingType) {
    switch (cachingType) {
      case CachingType.simple:
        return SimpleCachingService();
    }
  }

  @protected
  CachingDataFactory.init();

  BaseCacheService get cacheService;
}
