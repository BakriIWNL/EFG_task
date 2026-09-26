import 'package:efg_currency_converter/core/utils/extensions.dart';
import 'package:efg_currency_converter/core/utils/validations/model/amount_validations.dart';

mixin ValidationHelpers {
  static const int amountMaxDecimals = 2;

  static String? validateAmount(
    String amount,
    AmountValidations amountValidations,
  ) {
    return amount.validate([
      (value) => value?.validateRequired(
            value,
            errorMessage: amountValidations.requiredAmount,
          ),
      (value) => value?.validateNumber(
            value,
            errorMessage: amountValidations.invalidAmount,
          ),
      (value) => value?.validatePositive(
            value,
            errorMessage: amountValidations.positiveAmount,
          ),
      (value) => value?.validateMaxDecimals(
            value,
            amountMaxDecimals,
            errorMessage: amountValidations.maxDecimalsAmount,
          ),
    ]);
  }
}
