import 'package:efg_currency_converter/config/themes/tokens/index.dart';
import 'package:efg_currency_converter/core/controllers/theme_controller.dart';
import 'package:efg_currency_converter/core/utils/enums.dart';
import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomThemeButton extends StatelessWidget {
  const CustomThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return IconButton(
      tooltip: isDark
          ? context.localizations.switchToLightMode
          : context.localizations.switchToDarkMode,
      icon: AnimatedSwitcher(
        duration: AppDurations.slow,
        transitionBuilder: (child, animation) => RotationTransition(
          turns: Tween<double>(begin: 0.5, end: 1).animate(animation),
          child: ScaleTransition(scale: animation, child: child),
        ),
        child: Icon(
          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          key: ValueKey(isDark),
        ),
      ),
      onPressed: () => context
          .read<ThemeController>()
          .setTheme(isDark ? ThemeFlavor.light : ThemeFlavor.dark),
    );
  }
}
