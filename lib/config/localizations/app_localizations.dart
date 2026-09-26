import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localizations/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'EFG Currency Converter'**
  String get appTitle;

  /// No description provided for @convert.
  ///
  /// In en, this message translates to:
  /// **'Convert'**
  String get convert;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @noInternetDetected.
  ///
  /// In en, this message translates to:
  /// **'No internet detected'**
  String get noInternetDetected;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again later.'**
  String get somethingWentWrong;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @loadingCurrencies.
  ///
  /// In en, this message translates to:
  /// **'Loading currencies…'**
  String get loadingCurrencies;

  /// No description provided for @midMarketRates.
  ///
  /// In en, this message translates to:
  /// **'Mid-market rates, updated daily'**
  String get midMarketRates;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @amountHint.
  ///
  /// In en, this message translates to:
  /// **'0.00'**
  String get amountHint;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @convertFrom.
  ///
  /// In en, this message translates to:
  /// **'Convert from'**
  String get convertFrom;

  /// No description provided for @convertTo.
  ///
  /// In en, this message translates to:
  /// **'Convert to'**
  String get convertTo;

  /// No description provided for @selectCurrency.
  ///
  /// In en, this message translates to:
  /// **'Select a currency'**
  String get selectCurrency;

  /// No description provided for @searchCurrency.
  ///
  /// In en, this message translates to:
  /// **'Search by name or code'**
  String get searchCurrency;

  /// No description provided for @noCurrenciesMatch.
  ///
  /// In en, this message translates to:
  /// **'No currencies match \"{query}\".'**
  String noCurrenciesMatch(String query);

  /// No description provided for @swapCurrencies.
  ///
  /// In en, this message translates to:
  /// **'Swap currencies'**
  String get swapCurrencies;

  /// No description provided for @convertedAmount.
  ///
  /// In en, this message translates to:
  /// **'Converted amount'**
  String get convertedAmount;

  /// No description provided for @ratesAsOf.
  ///
  /// In en, this message translates to:
  /// **'Rates as of {date}'**
  String ratesAsOf(String date);

  /// No description provided for @ratesAsOfTime.
  ///
  /// In en, this message translates to:
  /// **'Rates as of {date}, {time}'**
  String ratesAsOfTime(String date, String time);

  /// No description provided for @ratesUpdatedAt.
  ///
  /// In en, this message translates to:
  /// **'Rates updated {date}, {time}'**
  String ratesUpdatedAt(String date, String time);

  /// No description provided for @outdated.
  ///
  /// In en, this message translates to:
  /// **'Outdated'**
  String get outdated;

  /// No description provided for @resultPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount and tap Convert to see the result here.'**
  String get resultPlaceholder;

  /// No description provided for @fetchingRates.
  ///
  /// In en, this message translates to:
  /// **'Fetching the latest rates…'**
  String get fetchingRates;

  /// No description provided for @amountRequired.
  ///
  /// In en, this message translates to:
  /// **'Amount is required.'**
  String get amountRequired;

  /// No description provided for @amountInvalid.
  ///
  /// In en, this message translates to:
  /// **'Amount must be a valid number.'**
  String get amountInvalid;

  /// No description provided for @amountPositive.
  ///
  /// In en, this message translates to:
  /// **'Amount must be greater than zero.'**
  String get amountPositive;

  /// No description provided for @amountMaxDecimals.
  ///
  /// In en, this message translates to:
  /// **'Amount can have at most 2 decimal places.'**
  String get amountMaxDecimals;

  /// No description provided for @conversionNotSaved.
  ///
  /// In en, this message translates to:
  /// **'Converted, but the result could not be saved to history.'**
  String get conversionNotSaved;

  /// No description provided for @clearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear history'**
  String get clearHistory;

  /// No description provided for @clearHistoryQuestion.
  ///
  /// In en, this message translates to:
  /// **'Clear history?'**
  String get clearHistoryQuestion;

  /// No description provided for @clearHistoryMessage.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes every saved conversion.'**
  String get clearHistoryMessage;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clearAll;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @couldNotClearHistory.
  ///
  /// In en, this message translates to:
  /// **'Could not clear the history.'**
  String get couldNotClearHistory;

  /// No description provided for @conversionDeleted.
  ///
  /// In en, this message translates to:
  /// **'Conversion deleted.'**
  String get conversionDeleted;

  /// No description provided for @couldNotDeleteConversion.
  ///
  /// In en, this message translates to:
  /// **'Could not delete the conversion.'**
  String get couldNotDeleteConversion;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @noConversionsYet.
  ///
  /// In en, this message translates to:
  /// **'No conversions yet'**
  String get noConversionsYet;

  /// No description provided for @noConversionsMessage.
  ///
  /// In en, this message translates to:
  /// **'Every conversion you make is saved here.'**
  String get noConversionsMessage;

  /// No description provided for @deleteConversion.
  ///
  /// In en, this message translates to:
  /// **'Delete conversion'**
  String get deleteConversion;

  /// No description provided for @recalculate.
  ///
  /// In en, this message translates to:
  /// **'Recalculate'**
  String get recalculate;

  /// No description provided for @recalculatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Recalculated with the latest rates.'**
  String get recalculatedSuccessfully;

  /// No description provided for @recalculatedFromCache.
  ///
  /// In en, this message translates to:
  /// **'Could not reach the server. Recalculated with the last saved rates.'**
  String get recalculatedFromCache;

  /// No description provided for @atRate.
  ///
  /// In en, this message translates to:
  /// **'at {rate}'**
  String atRate(String rate);

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @switchToLightMode.
  ///
  /// In en, this message translates to:
  /// **'Switch to light mode'**
  String get switchToLightMode;

  /// No description provided for @switchToDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Switch to dark mode'**
  String get switchToDarkMode;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
