part of '../screens/history_screen.dart';

class BuildHistoryList extends StatelessWidget {
  const BuildHistoryList({
    super.key,
    required this.conversions,
  });

  final List<Conversion> conversions;

  List<Object> get entries {
    final entries = <Object>[];
    DateTime? currentDay;
    for (final conversion in conversions) {
      final day = conversion.createdAt.dateOnly;
      if (day != currentDay) {
        entries.add(day);
        currentDay = day;
      }
      entries.add(conversion);
    }
    return entries;
  }

  String _dayLabel(BuildContext context, DateTime day) {
    if (day.isToday) {
      return context.localizations.today;
    } else if (day.isYesterday) {
      return context.localizations.yesterday;
    }
    return day.formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HistoryCubit>();
    final items = entries;
    return LayoutBuilder(
      builder: (context, constraints) {
        final minimumGutter = context.isMobile ? AppSpacing.lg : AppSpacing.xxl;
        final centeredGutter = (constraints.maxWidth - 720) / 2;
        final gutter =
            centeredGutter > minimumGutter ? centeredGutter : minimumGutter;
        return ListView.builder(
          padding: EdgeInsets.fromLTRB(
            gutter,
            AppSpacing.sm,
            gutter,
            AppSpacing.xxxl,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final entry = items[index];
            final delay = AppDurations.stagger * (index < 8 ? index : 0);
            if (entry is DateTime) {
              return FadeIn(
                delay: delay,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.xs,
                    AppSpacing.lg,
                    AppSpacing.xs,
                    AppSpacing.sm,
                  ),
                  child: CustomSectionLabel(text: _dayLabel(context, entry)),
                ),
              );
            } else if (entry is Conversion) {
              return FadeInUp(
                from: AppSpacing.xxl,
                duration: AppDurations.entrance,
                delay: delay,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: Dismissible(
                    key: ValueKey(entry.id),
                    direction: DismissDirection.endToStart,
                    background: const BuildDeleteBackground(),
                    onDismissed: (_) => cubit.deleteConversion(entry),
                    child: BuildHistoryTile(conversion: entry),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
