import 'package:efg_currency_converter/config/themes/app_color_scheme.dart';
import 'package:efg_currency_converter/config/themes/app_theme_flavor.dart';
import 'package:flutter/material.dart';

part 'dark_color_scheme.dart';

class DarkTheme extends AppThemeFlavor {
  DarkTheme() : super.init();

  @override
  Brightness get windowBrightness => Brightness.dark;

  @override
  ThemeData createThemeData(BuildContext context) {
    return buildThemeData(context, DarkColorScheme());
  }
}
