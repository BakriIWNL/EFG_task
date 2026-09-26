part of '../screens/converter_screen.dart';

class BuildRatesDate extends StatelessWidget {
  const BuildRatesDate({
    super.key,
    required this.conversion,
    required this.color,
  });

  final Conversion conversion;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (!conversion.isOutdated) {
      return BuildResultMetaRow(
        icon: Icons.event_rounded,
        text: context.localizations.ratesAsOf(
          conversion.rateDate.formattedDate,
        ),
        color: color,
      );
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: BuildResultMetaRow(
          icon: Icons.history_toggle_off_rounded,
          text: context.localizations.ratesAsOfTime(
            conversion.updatedAt.formattedDate,
            conversion.updatedAt.formattedTime,
          ),
          color: context.colorScheme.error,
          isBold: true,
        ),
      ),
    );
  }
}
