import 'package:efg_currency_converter/config/themes/tokens/index.dart';
import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class CustomBadge extends StatelessWidget {
  const CustomBadge({
    super.key,
    required this.text,
    this.isEmphasized = false,
  });

  final String text;
  final bool isEmphasized;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppDurations.medium,
      width: 56,
      height: 44,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: isEmphasized
            ? null
            : context.colorScheme.surfaceContainerHighest,
        gradient: isEmphasized
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [context.appTheme.jungle, context.appTheme.forest],
              )
            : null,
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: isEmphasized
            ? AppShadows.glow(context.appTheme.emerald)
            : null,
      ),
      child: AnimatedSwitcher(
        duration: AppDurations.medium,
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: FadeTransition(opacity: animation, child: child),
        ),
        child: FittedBox(
          key: ValueKey(text),
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            maxLines: 1,
            style: context.appTextStyles.titleMedium.tabular.copyWith(
              color: isEmphasized
                  ? context.appTheme.white
                  : context.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
