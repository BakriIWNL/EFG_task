part of '../screens/converter_screen.dart';

class BuildConverterLoadingWidget extends StatelessWidget {
  const BuildConverterLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final fieldRadius = BorderRadius.circular(AppRadius.lg);
    return Skeletonizer.zone(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(
          context.isMobile ? AppSpacing.lg : AppSpacing.xxl,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Bone.text(words: 2, fontSize: 11),
                ),
                const SizedBox(height: AppSpacing.md),
                CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Bone(height: 60, borderRadius: fieldRadius),
                      const SizedBox(height: AppSpacing.lg),
                      Bone(height: 68, borderRadius: fieldRadius),
                      const SizedBox(height: AppSpacing.sm),
                      const Center(child: Bone.circle(size: 48)),
                      const SizedBox(height: AppSpacing.sm),
                      Bone(height: 68, borderRadius: fieldRadius),
                      const SizedBox(height: AppSpacing.xxl),
                      Bone(
                        height: 56,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  context.localizations.loadingCurrencies,
                  style: context.appTextStyles.bodyMedium.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
