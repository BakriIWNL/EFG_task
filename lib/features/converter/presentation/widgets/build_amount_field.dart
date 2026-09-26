part of '../screens/converter_screen.dart';

class BuildAmountField extends StatelessWidget {
  const BuildAmountField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConverterCubit>();
    return BlocSelector<ConverterCubit, ConverterState, String>(
      selector: (state) => state.fromCurrency?.displaySymbol ?? '',
      builder: (context, symbol) {
        return CustomTextField(
          controller: cubit.amountController,
          labelText: context.localizations.amount,
          hintText: context.localizations.amountHint,
          suffixText: symbol,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.done,
          inputFormatters: [
            CustomInputFormatters.amountFormatter,
            CustomInputFormatters.commaToDotFormatter,
            CustomInputFormatters.amountLengthFormatter,
          ],
          style: context.appTextStyles.headlineSmall.tabular,
          validator: (_) => cubit.validateAmount(
            AmountValidations(
              requiredAmount: context.localizations.amountRequired,
              invalidAmount: context.localizations.amountInvalid,
              positiveAmount: context.localizations.amountPositive,
              maxDecimalsAmount: context.localizations.amountMaxDecimals,
            ),
          ),
          onFieldSubmitted: (_) => cubit.convert(),
        );
      },
    );
  }
}
