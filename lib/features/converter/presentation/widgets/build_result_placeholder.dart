part of '../screens/converter_screen.dart';

class BuildResultPlaceholder extends StatelessWidget {
  const BuildResultPlaceholder({
    super.key,
    this.isLoading = false,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: AppSpacing.xxxl,
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: isLoading
                ? const CustomProgressIndicator()
                : Icon(
                    Icons.currency_exchange_rounded,
                    color: context.colorScheme.primary,
                  ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            isLoading
                ? context.localizations.fetchingRates
                : context.localizations.resultPlaceholder,
            style: context.appTextStyles.bodyMedium.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
