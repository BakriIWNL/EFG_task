part of '../screens/history_screen.dart';

class BuildClearHistoryButton extends StatelessWidget {
  const BuildClearHistoryButton({super.key});

  void _confirmClear(BuildContext context) {
    final cubit = context.read<HistoryCubit>();
    UiAlerts.customDialog(
      context,
      title: context.localizations.clearHistoryQuestion,
      content: context.localizations.clearHistoryMessage,
      action: context.localizations.clearAll,
      cancel: context.localizations.cancel,
      isDestructive: true,
      onAction: () {
        context.pop();
        cubit.clearHistory();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HistoryCubit, HistoryState, bool>(
      selector: (state) => state.conversions.isNotEmpty,
      builder: (context, hasConversions) {
        if (!hasConversions) {
          return const SizedBox.shrink();
        }
        return IconButton(
          tooltip: context.localizations.clearHistory,
          icon: const Icon(Icons.delete_sweep_rounded),
          onPressed: () => _confirmClear(context),
        );
      },
    );
  }
}
