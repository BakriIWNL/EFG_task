import 'package:efg_currency_converter/config/themes/app_color_scheme.dart';
import 'package:efg_currency_converter/config/themes/app_text_styles.dart';
import 'package:efg_currency_converter/config/themes/app_theme_data.dart';
import 'package:efg_currency_converter/config/themes/flavors/flavors.dart';
import 'package:efg_currency_converter/config/themes/tokens/index.dart';
import 'package:efg_currency_converter/core/utils/enums.dart';
import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class AppThemeFlavor {
  factory AppThemeFlavor(ThemeFlavor flavor, Brightness platformBrightness) {
    switch (flavor) {
      case ThemeFlavor.light:
        return LightTheme();
      case ThemeFlavor.dark:
        return DarkTheme();
      case ThemeFlavor.system:
        return platformBrightness == Brightness.dark
            ? DarkTheme()
            : LightTheme();
    }
  }

  @protected
  AppThemeFlavor.init();

  static const String fontFamily = 'Manrope';

  Brightness get windowBrightness;

  ThemeData createThemeData(BuildContext context);

  @protected
  ThemeData buildThemeData(BuildContext context, AppColorScheme colorScheme) {
    final appTextStyles = context.isTablet
        ? AppTextStyles.tablet(fontFamily)
        : AppTextStyles.mobile(fontFamily);
    final textTheme = appTextStyles.toTextTheme().apply(
      fontFamily: fontFamily,
      bodyColor: colorScheme.ink,
      displayColor: colorScheme.ink,
    );
    final isDark = windowBrightness == Brightness.dark;
    final fieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      borderSide: BorderSide(color: colorScheme.lineSoft),
    );

    return ThemeData(
      brightness: windowBrightness,
      fontFamily: fontFamily,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.paper,
      colorScheme: ColorScheme(
        brightness: windowBrightness,
        primary: colorScheme.pine,
        onPrimary: colorScheme.onPine,
        primaryContainer: colorScheme.pineMist,
        onPrimaryContainer: colorScheme.pineDeep,
        secondary: colorScheme.slate,
        onSecondary: colorScheme.onSlate,
        secondaryContainer: colorScheme.slateMist,
        onSecondaryContainer: colorScheme.slateDeep,
        error: colorScheme.danger,
        onError: colorScheme.onDanger,
        errorContainer: colorScheme.dangerMist,
        onErrorContainer: colorScheme.dangerDeep,
        surface: colorScheme.paper,
        onSurface: colorScheme.ink,
        onSurfaceVariant: colorScheme.inkMuted,
        surfaceContainerLowest: colorScheme.paperLowest,
        surfaceContainerLow: colorScheme.paperLowest,
        surfaceContainer: colorScheme.paperRaised,
        surfaceContainerHigh: colorScheme.paperSunken,
        surfaceContainerHighest: colorScheme.paperSunken,
        outline: colorScheme.line,
        outlineVariant: colorScheme.lineSoft,
        inverseSurface: colorScheme.inverseInk,
        onInverseSurface: colorScheme.inversePaper,
        inversePrimary: colorScheme.inversePine,
      ),
      extensions: [
        AppThemeData.fromColorScheme(colorScheme),
        appTextStyles,
      ],
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        backgroundColor: colorScheme.paper,
        foregroundColor: colorScheme.ink,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.paperLowest,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          side: BorderSide(color: colorScheme.lineSoft),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.lineSoft,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.paperSunken,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.lg,
        ),
        border: fieldBorder,
        enabledBorder: fieldBorder,
        focusedBorder: fieldBorder.copyWith(
          borderSide: BorderSide(color: colorScheme.pine, width: 2),
        ),
        errorBorder: fieldBorder.copyWith(
          borderSide: BorderSide(color: colorScheme.danger),
        ),
        focusedErrorBorder: fieldBorder.copyWith(
          borderSide: BorderSide(color: colorScheme.danger, width: 2),
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.inkMuted,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.inkMuted,
        ),
        errorStyle: textTheme.bodySmall?.copyWith(color: colorScheme.danger),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 68,
        elevation: 0,
        backgroundColor: colorScheme.paperLowest,
        surfaceTintColor: Colors.transparent,
        indicatorColor: colorScheme.pineMist,
        indicatorShape: const StadiumBorder(),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => textTheme.labelMedium?.copyWith(
            color: states.contains(WidgetState.selected)
                ? colorScheme.pine
                : colorScheme.inkMuted,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w800
                : null,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? colorScheme.pineDeep
                : colorScheme.inkMuted,
          ),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colorScheme.paperLowest,
        indicatorColor: colorScheme.pineMist,
        indicatorShape: const StadiumBorder(),
        selectedIconTheme: IconThemeData(color: colorScheme.pineDeep),
        unselectedIconTheme: IconThemeData(color: colorScheme.inkMuted),
        selectedLabelTextStyle: textTheme.labelLarge?.copyWith(
          color: colorScheme.ink,
        ),
        unselectedLabelTextStyle: textTheme.labelLarge?.copyWith(
          color: colorScheme.inkMuted,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.paperLowest,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: colorScheme.line,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.xxl),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.paperLowest,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.inkMuted,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        insetPadding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.pine,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          shape: const CircleBorder(),
          highlightColor: colorScheme.pineMist,
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: colorScheme.inverseInk,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        textStyle: textTheme.bodySmall?.copyWith(
          color: colorScheme.inversePaper,
        ),
      ),
    );
  }
}
