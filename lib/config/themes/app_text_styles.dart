import 'package:flutter/material.dart';

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  const AppTextStyles._({
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  factory AppTextStyles.mobile(String fontFamily) {
    return AppTextStyles._scaled(fontFamily, 1);
  }

  factory AppTextStyles.tablet(String fontFamily) {
    return AppTextStyles._scaled(fontFamily, 1.06);
  }

  factory AppTextStyles._scaled(String fontFamily, double scale) {
    return AppTextStyles._(
      displayMedium: TextStyle(
        fontSize: 44 * scale,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        height: 1.08,
        letterSpacing: -1.4,
      ),
      displaySmall: TextStyle(
        fontSize: 34 * scale,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        height: 1.12,
        letterSpacing: -0.9,
      ),
      headlineMedium: TextStyle(
        fontSize: 28 * scale,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        height: 1.2,
        letterSpacing: -0.5,
      ),
      headlineSmall: TextStyle(
        fontSize: 24 * scale,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        height: 1.25,
        letterSpacing: -0.3,
      ),
      titleLarge: TextStyle(
        fontSize: 20 * scale,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        height: 1.3,
        letterSpacing: -0.2,
      ),
      titleMedium: TextStyle(
        fontSize: 16 * scale,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        height: 1.35,
        letterSpacing: -0.1,
      ),
      titleSmall: TextStyle(
        fontSize: 14 * scale,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily,
        height: 1.4,
      ),
      bodyLarge: TextStyle(
        fontSize: 16 * scale,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14 * scale,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontSize: 12 * scale,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        height: 1.45,
      ),
      labelLarge: TextStyle(
        fontSize: 15 * scale,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        height: 1.2,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontSize: 12 * scale,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily,
        height: 1.3,
        letterSpacing: 0.2,
      ),
      labelSmall: TextStyle(
        fontSize: 11 * scale,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        height: 1.3,
        letterSpacing: 1,
      ),
    );
  }

  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  TextTheme toTextTheme() {
    return TextTheme(
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    );
  }

  @override
  ThemeExtension<AppTextStyles> copyWith() {
    return this;
  }

  @override
  ThemeExtension<AppTextStyles> lerp(
    covariant ThemeExtension<AppTextStyles>? other,
    double t,
  ) {
    return this;
  }
}
