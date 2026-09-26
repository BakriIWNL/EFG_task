part of 'converter_cubit.dart';

class ConverterState extends Equatable {
  const ConverterState({
    this.currenciesState = GenericStates.initial,
    this.conversionState = GenericStates.initial,
    this.saveConversionState = GenericStates.initial,
    this.currencies = const [],
    this.cachedRates = const {},
    this.isOffline = false,
    this.fromCode = '',
    this.toCode = '',
    this.conversion,
    this.errorMessage = '',
  });

  final GenericStates currenciesState;
  final GenericStates conversionState;
  final GenericStates saveConversionState;
  final List<Currency> currencies;
  final Map<String, ExchangeRates> cachedRates;
  final bool isOffline;
  final String fromCode;
  final String toCode;
  final Conversion? conversion;
  final String errorMessage;

  List<Currency> get fromCurrencies {
    if (!isOffline) {
      return currencies;
    }
    return currencies
        .where((currency) => cachedRates.containsKey(currency.code))
        .toList();
  }

  List<Currency> get toCurrencies {
    if (!isOffline) {
      return currencies;
    }
    final rates = cachedRates[fromCode];
    if (rates == null) {
      return [];
    }
    return currencies
        .where(
          (currency) =>
              currency.code != fromCode &&
              rates.rates.containsKey(currency.code),
        )
        .toList();
  }

  bool get hasAvailableCurrencies => fromCurrencies.isNotEmpty;

  bool get canSwap {
    if (!isOffline) {
      return true;
    }
    return cachedRates[toCode]?.rates.containsKey(fromCode) ?? false;
  }

  Currency? get fromCurrency => findCurrency(fromCode);

  Currency? get toCurrency => findCurrency(toCode);

  Currency? findCurrency(String code) {
    for (final currency in currencies) {
      if (currency.code == code) {
        return currency;
      }
    }
    return null;
  }

  ConverterState copyWith({
    GenericStates? currenciesState,
    GenericStates? conversionState,
    GenericStates? saveConversionState,
    List<Currency>? currencies,
    Map<String, ExchangeRates>? cachedRates,
    bool? isOffline,
    String? fromCode,
    String? toCode,
    Conversion? conversion,
    String? errorMessage,
  }) {
    return ConverterState(
      currenciesState: currenciesState ?? this.currenciesState,
      conversionState: conversionState ?? this.conversionState,
      saveConversionState: saveConversionState ?? this.saveConversionState,
      currencies: currencies ?? this.currencies,
      cachedRates: cachedRates ?? this.cachedRates,
      isOffline: isOffline ?? this.isOffline,
      fromCode: fromCode ?? this.fromCode,
      toCode: toCode ?? this.toCode,
      conversion: conversion ?? this.conversion,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        currenciesState,
        conversionState,
        saveConversionState,
        currencies,
        cachedRates,
        isOffline,
        fromCode,
        toCode,
        conversion,
        errorMessage,
      ];
}
