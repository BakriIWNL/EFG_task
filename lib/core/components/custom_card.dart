import 'package:efg_currency_converter/config/themes/tokens/index.dart';
import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.xl),
    this.color,
    this.gradient,
    this.borderColor,
    this.borderRadius = AppRadius.xl,
    this.boxShadow,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final Gradient? gradient;
  final Color? borderColor;
  final double borderRadius;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);
    final content = Padding(padding: padding, child: child);
    return AnimatedContainer(
      duration: AppDurations.medium,
      curve: Curves.easeOutCubic,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: gradient == null
            ? color ?? context.colorScheme.surfaceContainerLowest
            : null,
        gradient: gradient,
        borderRadius: radius,
        border: Border.all(
          color:
              borderColor ??
              (gradient == null
                  ? context.colorScheme.outlineVariant
                  : Colors.transparent),
        ),
        boxShadow: boxShadow ?? AppShadows.soft(context.appTheme.shadow),
      ),
      child: onTap == null
          ? content
          : Material(
              type: MaterialType.transparency,
              child: InkWell(onTap: onTap, child: content),
            ),
    );
  }
}
