part of '../screens/history_screen.dart';

class BuildHistoryBody extends StatelessWidget {
  const BuildHistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HistoryCubit>();
    return MultiBlocListener(
      listeners: [
        BlocListener<HistoryCubit, HistoryState>(
          listenWhen: (previous, current) =>
              current.recalculatingIds.length <
              previous.recalculatingIds.length,
          listener: (context, state) {
            if (state.recalculateState == GenericStates.error) {
              CustomSnackBar.showError(
                context,
                context.localizations.somethingWentWrong,
              );
            } else if (state.recalculateState == GenericStates.success &&
                (state.recalculatedConversion?.isOutdated ?? false)) {
              CustomSnackBar.showProblem(
                context,
                context.localizations.recalculatedFromCache,
              );
            } else if (state.recalculateState == GenericStates.success) {
              CustomSnackBar.showSuccess(
                context,
                context.localizations.recalculatedSuccessfully,
              );
            }
          },
        ),
        BlocListener<HistoryCubit, HistoryState>(
          listenWhen: (previous, current) =>
              previous.deleteState != current.deleteState &&
              current.deleteState != GenericStates.loading,
          listener: (context, state) {
            final deletedConversion = state.deletedConversion;
            if (state.deleteState == GenericStates.success &&
                deletedConversion != null) {
              CustomSnackBar.showSuccess(
                context,
                context.localizations.conversionDeleted,
                actionLabel: context.localizations.undo,
                onAction: () => cubit.restoreConversion(deletedConversion),
              );
            } else if (state.deleteState == GenericStates.error) {
              CustomSnackBar.showError(
                context,
                context.localizations.couldNotDeleteConversion,
              );
            }
          },
        ),
        BlocListener<HistoryCubit, HistoryState>(
          listenWhen: (previous, current) =>
              previous.clearState != current.clearState &&
              current.clearState == GenericStates.error,
          listener: (context, state) => CustomSnackBar.showError(
            context,
            context.localizations.couldNotClearHistory,
          ),
        ),
      ],
      child: FadeIn(
        child: Column(
          children: [
            const ConnectivityBuilder(
              connectionWidget: SizedBox(width: double.infinity),
              noConnectionWidget: NoNetworkComponent(),
            ),
            Expanded(
              child: BlocBuilder<HistoryCubit, HistoryState>(
                buildWhen: (previous, current) =>
                    previous.state != current.state ||
                    previous.conversions != current.conversions,
                builder: (context, state) {
                  if (state.state == GenericStates.success &&
                      state.conversions.isEmpty) {
                    return CustomEmptyComponent(
                      icon: Icons.history_rounded,
                      title: context.localizations.noConversionsYet,
                      message: context.localizations.noConversionsMessage,
                    );
                  } else if (state.state == GenericStates.success) {
                    return BuildHistoryList(conversions: state.conversions);
                  } else if (state.state == GenericStates.error) {
                    return SomethingWentWrong(onTap: cubit.getHistory);
                  } else {
                    return const BuildHistoryLoadingWidget();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
