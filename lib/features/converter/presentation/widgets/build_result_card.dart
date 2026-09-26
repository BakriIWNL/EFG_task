part of '../screens/converter_screen.dart';

class BuildResultCard extends StatelessWidget {
  const BuildResultCard({
    super.key,
    required this.conversion,
  });

  final Conversion conversion;

  @override
  Widget build(BuildContext context) {
    final foreground = context.appTheme.white;
    final muted = foreground.withValues(alpha: 0.86);

    return CustomCard(
      padding: EdgeInsets.zero,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [context.appTheme.jungle, context.appTheme.forest],
      ),
      boxShadow: AppShadows.glow(context.appTheme.emerald),
      child: Stack(
        children: [
          PositionedDirectional(
            top: -56,
            end: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: foreground.withValues(alpha: 0.08),
              ),
            ),
          ),
          PositionedDirectional(
            bottom: -72,
            start: -48,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.appTheme.emerald.withValues(alpha: 0.18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSectionLabel(
                  text: context.localizations.convertedAmount,
                  color: muted,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  '${conversion.amount.withSymbol(conversion.fromSymbol)} =',
                  style: context.appTextStyles.titleMedium.tabular.copyWith(
                    color: muted,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: 0,
                    end: conversion.convertedAmount,
                  ),
                  duration: AppDurations.countUp,
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) => FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      value.withSymbol(conversion.toSymbol),
                      style:
                          context.appTextStyles.displayMedium.tabular.copyWith(
                        color: foreground,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Divider(color: foreground.withValues(alpha: 0.2)),
                const SizedBox(height: AppSpacing.md),
                BuildResultMetaRow(
                  icon: Icons.swap_horiz_rounded,
                  text: '${1.0.withSymbol(conversion.fromSymbol)} = '
                      '${conversion.rate.rateWithSymbol(conversion.toSymbol)}',
                  color: foreground,
                ),
                const SizedBox(height: AppSpacing.sm),
                BuildRatesDate(conversion: conversion, color: muted),
                if (conversion.isOutdated) ...[
                  const SizedBox(height: AppSpacing.lg),
                  ZoomIn(
                    duration: AppDurations.entrance,
                    child: CustomTag(
                      text: context.localizations.outdated,
                      icon: Icons.cloud_off_rounded,
                      backgroundColor: context.appTheme.amberMist,
                      textColor: context.appTheme.amberDeep,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
