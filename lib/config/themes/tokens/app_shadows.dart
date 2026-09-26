import 'package:flutter/material.dart';

mixin AppShadows {
  static List<BoxShadow> soft(Color color) {
    return [
      BoxShadow(
        color: color.withValues(alpha: 0.07),
        blurRadius: 24,
        offset: const Offset(0, 10),
      ),
      BoxShadow(
        color: color.withValues(alpha: 0.04),
        blurRadius: 6,
        offset: const Offset(0, 2),
      ),
    ];
  }

  static List<BoxShadow> raised(Color color) {
    return [
      BoxShadow(
        color: color.withValues(alpha: 0.12),
        blurRadius: 32,
        offset: const Offset(0, 14),
      ),
      BoxShadow(
        color: color.withValues(alpha: 0.06),
        blurRadius: 8,
        offset: const Offset(0, 3),
      ),
    ];
  }

  static List<BoxShadow> glow(Color color) {
    return [
      BoxShadow(
        color: color.withValues(alpha: 0.38),
        blurRadius: 24,
        spreadRadius: -4,
        offset: const Offset(0, 12),
      ),
    ];
  }
}
