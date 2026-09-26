import 'package:efg_currency_converter/config/themes/app_text_styles.dart';
import 'package:efg_currency_converter/config/themes/app_theme_data.dart';
import 'package:efg_currency_converter/config/themes/app_theme_flavor.dart';
import 'package:efg_currency_converter/core/controllers/theme_controller.dart';
import 'package:efg_currency_converter/core/utils/enums.dart';
import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppThemeBuilder extends StatelessWidget {
  const AppThemeBuilder({super.key, required this.builder});

  final Widget Function(ThemeData theme) builder;

  static AppThemeData? maybeOf(BuildContext context) {
    return context.theme.extension<AppThemeData>();
  }

  static AppThemeData of(BuildContext context) {
    return maybeOf(context)!;
  }

  static AppTextStyles? maybeTextStyleOf(BuildContext context) {
    return context.theme.extension<AppTextStyles>();
  }

  static AppTextStyles textStyleOf(BuildContext context) {
    return maybeTextStyleOf(context)!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeController, ThemeFlavor>(
      builder: (context, state) {
        final currentTheme = AppThemeFlavor(
          state,
          MediaQuery.platformBrightnessOf(context),
        ).createThemeData(context);
        return builder(currentTheme);
      },
    );
  }
}
