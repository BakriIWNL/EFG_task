import 'package:efg_currency_converter/config/themes/app_color_scheme.dart';
import 'package:efg_currency_converter/config/themes/app_theme_flavor.dart';
import 'package:flutter/material.dart';

part 'light_color_scheme.dart';

class LightTheme extends AppThemeFlavor {
  LightTheme() : super.init();

  @override
  Brightness get windowBrightness => Brightness.light;

  @override
  ThemeData createThemeData(BuildContext context) {
    return buildThemeData(context, LightColorScheme());
  }
}
