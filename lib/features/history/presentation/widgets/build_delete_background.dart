part of '../screens/history_screen.dart';

class BuildDeleteBackground extends StatelessWidget {
  const BuildDeleteBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.centerEnd,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
      decoration: BoxDecoration(
        color: context.colorScheme.error,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Icon(
        Icons.delete_outline_rounded,
        color: context.colorScheme.onError,
      ),
    );
  }
}
