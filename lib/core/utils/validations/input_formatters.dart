import 'package:efg_currency_converter/core/utils/validations/regex_patterns.dart';
import 'package:flutter/services.dart';

class CustomInputFormatters {
  static final amountFormatter = FilteringTextInputFormatter.allow(
    RegExp(RegexPatterns.amountPattern),
  );

  static final commaToDotFormatter = TextInputFormatter.withFunction(
    (oldValue, newValue) => newValue.copyWith(
      text: newValue.text.replaceAll(',', '.'),
    ),
  );

  static final amountLengthFormatter = LengthLimitingTextInputFormatter(15);
}
