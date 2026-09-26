import 'package:efg_currency_converter/config/themes/app_color_scheme.dart';
import 'package:efg_currency_converter/core/utils/typedef.dart';
import 'package:flutter/material.dart';

class AppThemeData extends AppThemeExtension {
  const AppThemeData({
    required this.white,
    required this.pine,
    required this.onPine,
    required this.pineMist,
    required this.pineDeep,
    required this.emerald,
    required this.jungle,
    required this.forest,
    required this.slate,
    required this.onSlate,
    required this.slateMist,
    required this.slateDeep,
    required this.paper,
    required this.paperLowest,
    required this.paperRaised,
    required this.paperSunken,
    required this.ink,
    required this.inkMuted,
    required this.line,
    required this.lineSoft,
    required this.shadow,
    required this.danger,
    required this.onDanger,
    required this.dangerMist,
    required this.dangerDeep,
    required this.thunderbird,
    required this.amber,
    required this.amberMist,
    required this.amberDeep,
  });

  factory AppThemeData.fromColorScheme(AppColorScheme colorScheme) {
    return AppThemeData(
      white: colorScheme.white,
      pine: colorScheme.pine,
      onPine: colorScheme.onPine,
      pineMist: colorScheme.pineMist,
      pineDeep: colorScheme.pineDeep,
      emerald: colorScheme.emerald,
      jungle: colorScheme.jungle,
      forest: colorScheme.forest,
      slate: colorScheme.slate,
      onSlate: colorScheme.onSlate,
      slateMist: colorScheme.slateMist,
      slateDeep: colorScheme.slateDeep,
      paper: colorScheme.paper,
      paperLowest: colorScheme.paperLowest,
      paperRaised: colorScheme.paperRaised,
      paperSunken: colorScheme.paperSunken,
      ink: colorScheme.ink,
      inkMuted: colorScheme.inkMuted,
      line: colorScheme.line,
      lineSoft: colorScheme.lineSoft,
      shadow: colorScheme.shadow,
      danger: colorScheme.danger,
      onDanger: colorScheme.onDanger,
      dangerMist: colorScheme.dangerMist,
      dangerDeep: colorScheme.dangerDeep,
      thunderbird: colorScheme.thunderbird,
      amber: colorScheme.amber,
      amberMist: colorScheme.amberMist,
      amberDeep: colorScheme.amberDeep,
    );
  }

  final Color white;
  final Color pine;
  final Color onPine;
  final Color pineMist;
  final Color pineDeep;
  final Color emerald;
  final Color jungle;
  final Color forest;
  final Color slate;
  final Color onSlate;
  final Color slateMist;
  final Color slateDeep;
  final Color paper;
  final Color paperLowest;
  final Color paperRaised;
  final Color paperSunken;
  final Color ink;
  final Color inkMuted;
  final Color line;
  final Color lineSoft;
  final Color shadow;
  final Color danger;
  final Color onDanger;
  final Color dangerMist;
  final Color dangerDeep;
  final Color thunderbird;
  final Color amber;
  final Color amberMist;
  final Color amberDeep;

  @override
  ThemeExtension<AppThemeData> copyWith() {
    return this;
  }

  @override
  AppThemeExtension lerp(AppThemeExtension? other, double t) {
    if (other is! AppThemeData) return this;

    final normT = t.clamp(0, 1).toDouble();
    Color lerpColor(Color color1, Color color2) {
      return Color.lerp(color1, color2, normT)!;
    }

    return AppThemeData(
      white: lerpColor(white, other.white),
      pine: lerpColor(pine, other.pine),
      onPine: lerpColor(onPine, other.onPine),
      pineMist: lerpColor(pineMist, other.pineMist),
      pineDeep: lerpColor(pineDeep, other.pineDeep),
      emerald: lerpColor(emerald, other.emerald),
      jungle: lerpColor(jungle, other.jungle),
      forest: lerpColor(forest, other.forest),
      slate: lerpColor(slate, other.slate),
      onSlate: lerpColor(onSlate, other.onSlate),
      slateMist: lerpColor(slateMist, other.slateMist),
      slateDeep: lerpColor(slateDeep, other.slateDeep),
      paper: lerpColor(paper, other.paper),
      paperLowest: lerpColor(paperLowest, other.paperLowest),
      paperRaised: lerpColor(paperRaised, other.paperRaised),
      paperSunken: lerpColor(paperSunken, other.paperSunken),
      ink: lerpColor(ink, other.ink),
      inkMuted: lerpColor(inkMuted, other.inkMuted),
      line: lerpColor(line, other.line),
      lineSoft: lerpColor(lineSoft, other.lineSoft),
      shadow: lerpColor(shadow, other.shadow),
      danger: lerpColor(danger, other.danger),
      onDanger: lerpColor(onDanger, other.onDanger),
      dangerMist: lerpColor(dangerMist, other.dangerMist),
      dangerDeep: lerpColor(dangerDeep, other.dangerDeep),
      thunderbird: lerpColor(thunderbird, other.thunderbird),
      amber: lerpColor(amber, other.amber),
      amberMist: lerpColor(amberMist, other.amberMist),
      amberDeep: lerpColor(amberDeep, other.amberDeep),
    );
  }
}
