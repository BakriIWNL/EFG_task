part of '../screens/converter_screen.dart';

class BuildConversionErrorCard extends StatelessWidget {
  const BuildConversionErrorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ShakeX(
      from: AppSpacing.sm,
      duration: AppDurations.entrance,
      child: CustomCard(
        color: context.colorScheme.errorContainer,
        borderColor: context.colorScheme.error.withValues(alpha: 0.3),
        boxShadow: AppShadows.soft(context.colorScheme.error),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: context.colorScheme.error.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: context.colorScheme.onErrorContainer,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                context.localizations.somethingWentWrong,
                style: context.appTextStyles.bodyMedium.copyWith(
                  color: context.colorScheme.onErrorContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
