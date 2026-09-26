part of '../screens/history_screen.dart';

class BuildHistoryLoadingWidget extends StatelessWidget {
  const BuildHistoryLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer.zone(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(
          context.isMobile ? AppSpacing.lg : AppSpacing.xxl,
        ),
        itemCount: 4,
        separatorBuilder: (context, index) =>
            const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) => Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: CustomListTile(
              isElevated: true,
              leading: Bone(
                width: 56,
                height: 72,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              title: const Bone.text(words: 2),
              subtitle: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSpacing.xs),
                  Bone.text(words: 4, fontSize: 12),
                  SizedBox(height: AppSpacing.xs),
                  Bone.text(words: 3, fontSize: 12),
                ],
              ),
              footer: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: AppSpacing.sm,
                  ),
                  child: Bone(
                    width: 136,
                    height: 40,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
