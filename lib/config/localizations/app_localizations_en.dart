// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'EFG Currency Converter';

  @override
  String get convert => 'Convert';

  @override
  String get history => 'History';

  @override
  String get noInternetDetected => 'No internet detected';

  @override
  String get somethingWentWrong =>
      'Something went wrong. Please try again later.';

  @override
  String get retry => 'Try again';

  @override
  String get loadingCurrencies => 'Loading currencies…';

  @override
  String get midMarketRates => 'Mid-market rates, updated daily';

  @override
  String get amount => 'Amount';

  @override
  String get amountHint => '0.00';

  @override
  String get from => 'From';

  @override
  String get to => 'To';

  @override
  String get convertFrom => 'Convert from';

  @override
  String get convertTo => 'Convert to';

  @override
  String get selectCurrency => 'Select a currency';

  @override
  String get searchCurrency => 'Search by name or code';

  @override
  String noCurrenciesMatch(String query) {
    return 'No currencies match \"$query\".';
  }

  @override
  String get swapCurrencies => 'Swap currencies';

  @override
  String get convertedAmount => 'Converted amount';

  @override
  String ratesAsOf(String date) {
    return 'Rates as of $date';
  }

  @override
  String ratesAsOfTime(String date, String time) {
    return 'Rates as of $date, $time';
  }

  @override
  String ratesUpdatedAt(String date, String time) {
    return 'Rates updated $date, $time';
  }

  @override
  String get outdated => 'Outdated';

  @override
  String get resultPlaceholder =>
      'Enter an amount and tap Convert to see the result here.';

  @override
  String get fetchingRates => 'Fetching the latest rates…';

  @override
  String get amountRequired => 'Amount is required.';

  @override
  String get amountInvalid => 'Amount must be a valid number.';

  @override
  String get amountPositive => 'Amount must be greater than zero.';

  @override
  String get amountMaxDecimals => 'Amount can have at most 2 decimal places.';

  @override
  String get conversionNotSaved =>
      'Converted, but the result could not be saved to history.';

  @override
  String get clearHistory => 'Clear history';

  @override
  String get clearHistoryQuestion => 'Clear history?';

  @override
  String get clearHistoryMessage =>
      'This permanently deletes every saved conversion.';

  @override
  String get clearAll => 'Clear all';

  @override
  String get cancel => 'Cancel';

  @override
  String get couldNotClearHistory => 'Could not clear the history.';

  @override
  String get conversionDeleted => 'Conversion deleted.';

  @override
  String get couldNotDeleteConversion => 'Could not delete the conversion.';

  @override
  String get undo => 'Undo';

  @override
  String get noConversionsYet => 'No conversions yet';

  @override
  String get noConversionsMessage => 'Every conversion you make is saved here.';

  @override
  String get deleteConversion => 'Delete conversion';

  @override
  String get recalculate => 'Recalculate';

  @override
  String get recalculatedSuccessfully => 'Recalculated with the latest rates.';

  @override
  String get recalculatedFromCache =>
      'Could not reach the server. Recalculated with the last saved rates.';

  @override
  String atRate(String rate) {
    return 'at $rate';
  }

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get switchToLightMode => 'Switch to light mode';

  @override
  String get switchToDarkMode => 'Switch to dark mode';
}
