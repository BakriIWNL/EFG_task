part of '../screens/history_screen.dart';

class BuildPairBadge extends StatelessWidget {
  const BuildPairBadge({
    super.key,
    required this.fromSymbol,
    required this.toSymbol,
  });

  final String fromSymbol;
  final String toSymbol;

  @override
  Widget build(BuildContext context) {
    final muted = context.colorScheme.onSurfaceVariant;
    return Container(
      width: 56,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            context.colorScheme.surfaceContainerHighest,
            context.colorScheme.primaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              fromSymbol,
              maxLines: 1,
              style: context.appTextStyles.labelLarge.tabular.copyWith(
                color: muted,
              ),
            ),
          ),
          Icon(Icons.arrow_downward_rounded, size: 12, color: muted),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              toSymbol,
              maxLines: 1,
              style: context.appTextStyles.titleMedium.tabular.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
