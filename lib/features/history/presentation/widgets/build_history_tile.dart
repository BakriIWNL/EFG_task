part of '../screens/history_screen.dart';

class BuildHistoryTile extends StatelessWidget {
  const BuildHistoryTile({
    super.key,
    required this.conversion,
  });

  final Conversion conversion;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HistoryCubit>();
    final muted = context.colorScheme.onSurfaceVariant;
    final details = [
      conversion.amount.withSymbol(conversion.fromSymbol),
      context.localizations.atRate(conversion.rate.formattedRate),
      conversion.createdAt.formattedTime,
    ].join(' · ');

    return CustomListTile(
      isElevated: true,
      leading: BuildPairBadge(
        fromSymbol: conversion.fromSymbol,
        toSymbol: conversion.toSymbol,
      ),
      title: Text(
        conversion.convertedAmount.withSymbol(conversion.toSymbol),
        style: context.appTextStyles.titleMedium.tabular,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            details,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          AnimatedDefaultTextStyle(
            duration: AppDurations.medium,
            style: context.appTextStyles.bodySmall.copyWith(
              color: conversion.isOutdated ? context.colorScheme.error : muted,
              fontWeight: conversion.isOutdated ? FontWeight.w700 : null,
            ),
            child: Text(
              context.localizations.ratesUpdatedAt(
                conversion.updatedAt.formattedDate,
                conversion.updatedAt.formattedTime,
              ),
            ),
          ),
          AnimatedSize(
            duration: AppDurations.medium,
            curve: Curves.easeOutCubic,
            alignment: AlignmentDirectional.topStart,
            child: conversion.isOutdated
                ? Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.sm),
                    child: ZoomIn(
                      duration: AppDurations.entrance,
                      child: CustomTag(
                        text: context.localizations.outdated,
                        icon: Icons.cloud_off_rounded,
                        backgroundColor: context.appTheme.amberMist,
                        textColor: context.appTheme.amberDeep,
                      ),
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
      trailing: IconButton(
        tooltip: context.localizations.deleteConversion,
        icon: const Icon(Icons.delete_outline_rounded),
        color: muted,
        onPressed: () => cubit.deleteConversion(conversion),
      ),
      footer: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
          child: BlocSelector<HistoryCubit, HistoryState, bool>(
            selector: (state) => state.recalculatingIds.contains(conversion.id),
            builder: (context, isLoading) => ConvertButton(
              text: context.localizations.recalculate,
              isLoading: isLoading,
              isCompact: true,
              onTap: () => cubit.recalculate(conversion),
            ),
          ),
        ),
      ),
    );
  }
}
