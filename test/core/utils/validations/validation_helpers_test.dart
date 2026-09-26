import 'package:efg_currency_converter/core/utils/validations/model/amount_validations.dart';
import 'package:efg_currency_converter/core/utils/validations/validation_helpers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tAmountValidations = AmountValidations(
    requiredAmount: 'required',
    invalidAmount: 'invalid',
    positiveAmount: 'positive',
    maxDecimalsAmount: 'decimals',
  );

  String? validate(String value) {
    return ValidationHelpers.validateAmount(value, tAmountValidations);
  }

  group('ValidationHelpers.validateAmount', () {
    test('rejects empty and whitespace only input', () {
      expect(validate(''), 'required');
      expect(validate('   '), 'required');
    });

    test('rejects input that is not a number', () {
      expect(validate('.'), 'invalid');
      expect(validate('1.2.3'), 'invalid');
    });

    test('rejects zero', () {
      expect(validate('0'), 'positive');
      expect(validate('0.00'), 'positive');
    });

    test('rejects more than two decimal places', () {
      expect(validate('1.234'), 'decimals');
    });

    test('accepts positive amounts with up to two decimal places', () {
      expect(validate('5'), isNull);
      expect(validate('0.01'), isNull);
      expect(validate('1250.50'), isNull);
    });
  });
}
