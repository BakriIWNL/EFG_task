import 'package:efg_currency_converter/config/localizations/app_localizations.dart';
import 'package:efg_currency_converter/config/themes/app_text_styles.dart';
import 'package:efg_currency_converter/config/themes/app_theme_builder.dart';
import 'package:efg_currency_converter/config/themes/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final _amountFormat = NumberFormat('#,##0.00', 'en_US');
final _preciseFormat = NumberFormat('#,##0.0000##', 'en_US');
final _dateFormat = DateFormat('d MMM yyyy', 'en_US');
final _timeFormat = DateFormat('HH:mm', 'en_US');

String _joinSymbol(String symbol, String value) {
  return symbol.runes.length == 1 ? '$symbol$value' : '$symbol $value';
}

extension Themes on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get screenSize => MediaQuery.sizeOf(this);

  double get height => screenSize.height;

  double get width => screenSize.width;

  bool get isMobile => width <= 600;

  bool get isTablet => width > 600;

  bool get isDesktop => width > 950;

  bool get isDarkMode => theme.brightness == Brightness.dark;

  ColorScheme get colorScheme => theme.colorScheme;

  AppThemeData get appTheme => AppThemeBuilder.of(this);

  AppTextStyles get appTextStyles => AppThemeBuilder.textStyleOf(this);

  AppLocalizations get localizations => AppLocalizations.of(this);
}

extension FieldValidate on String {
  String? validate(List<String? Function(String?)> functions) {
    for (final String? Function(String?) func in functions) {
      final result = func(this);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}

extension ValidationContext on String {
  String? validateRequired(String? value, {String? errorMessage}) {
    return (value ?? '').trim().isEmpty ? errorMessage : null;
  }

  String? validateNumber(String? value, {String? errorMessage}) {
    final parsed = double.tryParse((value ?? '').trim());
    return parsed == null || !parsed.isFinite ? errorMessage : null;
  }

  String? validatePositive(String? value, {String? errorMessage}) {
    final parsed = double.tryParse((value ?? '').trim()) ?? 0;
    return parsed > 0 ? null : errorMessage;
  }

  String? validateMaxDecimals(
    String? value,
    int digits, {
    String? errorMessage,
  }) {
    final text = (value ?? '').trim();
    final separator = text.indexOf('.');
    if (separator == -1) {
      return null;
    }
    return text.length - separator - 1 > digits ? errorMessage : null;
  }
}

extension TabularFigures on TextStyle {
  TextStyle get tabular {
    return copyWith(fontFeatures: const [FontFeature.tabularFigures()]);
  }
}

extension AmountFormatter on double {
  String get formattedAmount {
    final magnitude = abs();
    return magnitude > 0 && magnitude < 1
        ? _preciseFormat.format(this)
        : _amountFormat.format(this);
  }

  String get formattedRate => _preciseFormat.format(this);

  String withSymbol(String symbol) => _joinSymbol(symbol, formattedAmount);

  String rateWithSymbol(String symbol) => _joinSymbol(symbol, formattedRate);
}

extension DateFormatter on DateTime {
  String get formattedDate => _dateFormat.format(this);

  String get formattedTime => _timeFormat.format(this);

  DateTime get dateOnly => DateTime(year, month, day);

  bool get isToday => dateOnly == DateTime.now().dateOnly;

  bool get isYesterday {
    final now = DateTime.now();
    return dateOnly == DateTime(now.year, now.month, now.day - 1);
  }
}
