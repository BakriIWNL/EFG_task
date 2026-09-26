part of '../screens/history_screen.dart';

class BuildHistoryList extends StatefulWidget {
  const BuildHistoryList({
    super.key,
    required this.conversions,
  });

  final List<Conversion> conversions;

  @override
  State<BuildHistoryList> createState() => BuildHistoryListState();
}

class BuildHistoryListState extends State<BuildHistoryList> {
  bool isEntering = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => isEntering = false);
  }

  List<Object> get entries {
    final entries = <Object>[];
    DateTime? currentDay;
    for (final conversion in widget.conversions) {
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
            final Widget child;
            if (entry is DateTime) {
              child = Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xs,
                  AppSpacing.lg,
                  AppSpacing.xs,
                  AppSpacing.sm,
                ),
                child: CustomSectionLabel(text: _dayLabel(context, entry)),
              );
            } else if (entry is Conversion) {
              child = Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: Dismissible(
                  key: ValueKey(entry.id),
                  direction: DismissDirection.endToStart,
                  background: const BuildDeleteBackground(),
                  onDismissed: (_) => cubit.deleteConversion(entry),
                  child: BuildHistoryTile(conversion: entry),
                ),
              );
            } else {
              child = const SizedBox.shrink();
            }
            if (!isEntering) {
              return child;
            }
            return FadeInUp(
              from: AppSpacing.xxl,
              duration: AppDurations.entrance,
              delay: AppDurations.stagger * index.clamp(0, 8),
              child: child,
            );
          },
        );
      },
    );
  }
}
