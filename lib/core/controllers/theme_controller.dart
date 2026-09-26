import 'package:efg_currency_converter/core/services/local/cache/caching_data_factory.dart';
import 'package:efg_currency_converter/core/services/local/cache/repository/base_caching_service.dart';
import 'package:efg_currency_converter/core/utils/app_strings.dart';
import 'package:efg_currency_converter/core/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeController extends Cubit<ThemeFlavor> {
  ThemeController() : super(ThemeFlavor.system);

  final BaseCacheService _service =
      CachingDataFactory(CachingType.simple).cacheService;

  Future<void> init() async {
    final savedFlavorValue = await _service.readString(AppStrings.themeKey);
    if (savedFlavorValue != null && !isClosed) {
      emit(ThemeFlavor.fromString(savedFlavorValue));
    }
  }

  Future<void> setTheme(ThemeFlavor flavor) async {
    emit(flavor);
    await _service.writeString(AppStrings.themeKey, flavor.name);
  }
}
