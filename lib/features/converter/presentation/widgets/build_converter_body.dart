part of '../screens/converter_screen.dart';

class BuildConverterBody extends StatelessWidget {
  const BuildConverterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NetworkCubit, InternetState>(
          listener: (context, state) =>
              context.read<ConverterCubit>().changeConnectivity(state),
        ),
        BlocListener<ConverterCubit, ConverterState>(
          listenWhen: (previous, current) =>
              previous.saveConversionState != current.saveConversionState &&
              current.saveConversionState == GenericStates.error,
          listener: (context, state) => CustomSnackBar.showProblem(
            context,
            context.localizations.conversionNotSaved,
          ),
        ),
      ],
      child: WidgetLifecycleListener(
        onInit: () => context
            .read<ConverterCubit>()
            .changeConnectivity(context.read<NetworkCubit>().state),
        child: FadeIn(
          child: Column(
            children: [
              const ConnectivityBuilder(
                connectionWidget: SizedBox(width: double.infinity),
                noConnectionWidget: NoNetworkComponent(),
              ),
              Expanded(
                child: BlocBuilder<ConverterCubit, ConverterState>(
                  buildWhen: (previous, current) =>
                      previous.currenciesState != current.currenciesState ||
                      previous.hasAvailableCurrencies !=
                          current.hasAvailableCurrencies,
                  builder: (context, state) {
                    if (state.currenciesState == GenericStates.success &&
                        state.hasAvailableCurrencies) {
                      return const BuildConverterForm();
                    } else if (state.currenciesState ==
                            GenericStates.success ||
                        state.currenciesState == GenericStates.error) {
                      return SomethingWentWrong(
                        onTap: context.read<ConverterCubit>().getCurrencies,
                      );
                    } else {
                      return const BuildConverterLoadingWidget();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
