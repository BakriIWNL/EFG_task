part of '../screens/converter_screen.dart';

class BuildConverterForm extends StatelessWidget {
  const BuildConverterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConverterCubit>();
    final formCard = FadeInUp(
      from: AppSpacing.xxl,
      duration: AppDurations.entrance,
      child: CustomCard(
        child: Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const BuildAmountField(),
              const SizedBox(height: AppSpacing.lg),
              const BuildCurrencyPair(),
              const SizedBox(height: AppSpacing.xxl),
              BlocSelector<ConverterCubit, ConverterState, bool>(
                selector: (state) =>
                    state.conversionState == GenericStates.loading,
                builder: (context, isLoading) => ConvertButton(
                  text: context.localizations.convert,
                  isLoading: isLoading,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    cubit.convert();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    final result = FadeInUp(
      from: AppSpacing.xxl,
      duration: AppDurations.entrance,
      delay: AppDurations.stagger * 2,
      child: const BuildConversionResult(),
    );

    final layout = context.isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: formCard),
              const SizedBox(width: AppSpacing.xxl),
              Expanded(child: result),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              formCard,
              const SizedBox(height: AppSpacing.xl),
              result,
            ],
          );

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.all(
        context.isMobile ? AppSpacing.lg : AppSpacing.xxl,
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: context.isDesktop ? 1040 : 640,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomSectionLabel(text: context.localizations.midMarketRates),
              const SizedBox(height: AppSpacing.md),
              layout,
            ],
          ),
        ),
      ),
    );
  }
}
