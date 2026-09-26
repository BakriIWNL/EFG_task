import 'package:efg_currency_converter/core/utils/enums.dart';
import 'package:efg_currency_converter/core/utils/validations/model/amount_validations.dart';
import 'package:efg_currency_converter/core/utils/validations/validation_helpers.dart';
import 'package:efg_currency_converter/features/converter/data/models/currency.dart';
import 'package:efg_currency_converter/features/converter/data/models/exchange_rates.dart';
import 'package:efg_currency_converter/features/converter/data/repositories/local/local_converter_repository.dart';
import 'package:efg_currency_converter/features/converter/data/repositories/remote/converter_repository.dart';
import 'package:efg_currency_converter/features/history/data/models/conversion.dart';
import 'package:efg_currency_converter/features/history/data/repositories/local/local_history_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'converter_state.dart';

class ConverterCubit extends Cubit<ConverterState> {
  ConverterCubit(
    this._repository,
    this._localRepository,
    this._localHistoryRepository,
  ) : super(const ConverterState());

  static const String preferredFromCode = 'USD';
  static const String preferredToCode = 'EUR';

  final ConverterRepository _repository;
  final LocalConverterRepository _localRepository;
  final LocalHistoryRepository _localHistoryRepository;
  final amountController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Future<void> close() {
    amountController.dispose();
    return super.close();
  }

  String? validateAmount(AmountValidations amountValidations) {
    return ValidationHelpers.validateAmount(
      amountController.text,
      amountValidations,
    );
  }

  Future<void> getCurrencies() async {
    emit(state.copyWith(currenciesState: GenericStates.loading));
    final result = await _repository.getCurrencies();
    await result.fold(
      (failure) async {
        final cachedCurrencies = await _localRepository.getCachedCurrencies();
        if (cachedCurrencies.isEmpty) {
          if (isClosed) return;
          emit(
            state.copyWith(
              currenciesState: GenericStates.error,
              errorMessage: failure.message,
            ),
          );
          return;
        }
        await _emitCurrencies(cachedCurrencies);
      },
      (currencies) async {
        await cacheCurrencies(currencies);
        await _emitCurrencies(currencies);
      },
    );
  }

  Future<void> cacheCurrencies(List<Currency> currencies) async {
    await _localRepository.cacheCurrencies(currencies);
  }

  Future<void> cacheRates(ExchangeRates rates) async {
    await _localRepository.cacheRates(rates);
    if (isClosed) return;
    emit(
      state.copyWith(
        cachedRates: {...state.cachedRates, rates.base: rates},
      ),
    );
  }

  Future<void> getCachedRates() async {
    final cachedRates = await _localRepository.getCachedRates();
    if (isClosed) return;
    emit(_withValidSelection(state.copyWith(cachedRates: cachedRates)));
  }

  Future<void> changeConnectivity(InternetState internetState) async {
    final isOffline = internetState == InternetState.offState;
    if (isOffline == state.isOffline) return;
    emit(state.copyWith(isOffline: isOffline));
    if (isOffline) {
      await getCachedRates();
    } else if (state.currenciesState == GenericStates.error) {
      await getCurrencies();
    }
  }

  void selectFrom(String code) {
    if (code == state.fromCode) return;
    if (code == state.toCode) {
      swap();
      return;
    }
    emit(
      _withValidSelection(
        state.copyWith(
          fromCode: code,
          conversionState: GenericStates.initial,
        ),
      ),
    );
  }

  void selectTo(String code) {
    if (code == state.toCode) return;
    if (code == state.fromCode) {
      swap();
      return;
    }
    emit(
      state.copyWith(
        toCode: code,
        conversionState: GenericStates.initial,
      ),
    );
  }

  void swap() {
    if (!state.canSwap) return;
    emit(
      state.copyWith(
        fromCode: state.toCode,
        toCode: state.fromCode,
        conversionState: GenericStates.initial,
      ),
    );
  }

  Future<void> convert() async {
    if (formKey.currentState?.validate() ?? false) {
      await convertAmount(double.parse(amountController.text.trim()));
    }
  }

  Future<void> convertAmount(double amount) async {
    final from = state.fromCurrency;
    final to = state.toCurrency;
    if (from == null || to == null || from.code == to.code) return;

    emit(
      state.copyWith(
        conversionState: GenericStates.loading,
        saveConversionState: GenericStates.initial,
      ),
    );

    final result = await _repository.getRates(from.code);
    await result.fold(
      (failure) async {
        final cachedRates = await _localRepository.getCachedRates();
        final rates = cachedRates[from.code];
        if (rates == null || rates.rateFor(to.code) == null) {
          if (isClosed) return;
          emit(
            state.copyWith(
              conversionState: GenericStates.error,
              errorMessage: failure.message,
              cachedRates: cachedRates,
            ),
          );
          return;
        }
        await _saveConversion(
          _buildConversion(
            amount: amount,
            from: from,
            to: to,
            rates: rates,
            isOutdated: true,
          ),
        );
      },
      (rates) async {
        await cacheRates(rates);
        if (rates.rateFor(to.code) == null) {
          if (isClosed) return;
          emit(
            state.copyWith(
              conversionState: GenericStates.error,
              errorMessage: 'No rate is available for ${from.code} to '
                  '${to.code}.',
            ),
          );
          return;
        }
        await _saveConversion(
          _buildConversion(
            amount: amount,
            from: from,
            to: to,
            rates: rates,
            isOutdated: false,
          ),
        );
      },
    );
  }

  Conversion _buildConversion({
    required double amount,
    required Currency from,
    required Currency to,
    required ExchangeRates rates,
    required bool isOutdated,
  }) {
    return Conversion.fromRates(
      amount: amount,
      fromCode: from.code,
      toCode: to.code,
      fromSymbol: from.displaySymbol,
      toSymbol: to.displaySymbol,
      rates: rates,
      createdAt: DateTime.now(),
      isOutdated: isOutdated,
    );
  }

  Future<void> _saveConversion(Conversion conversion) async {
    final isSaved = await _localHistoryRepository.saveConversion(conversion);
    if (isClosed) return;
    emit(
      state.copyWith(
        conversionState: GenericStates.success,
        conversion: conversion,
        saveConversionState:
            isSaved ? GenericStates.success : GenericStates.error,
      ),
    );
  }

  Future<void> _emitCurrencies(List<Currency> currencies) async {
    final cachedRates = await _localRepository.getCachedRates();
    if (isClosed) return;
    emit(
      _withValidSelection(
        state.copyWith(
          currenciesState: GenericStates.success,
          currencies: currencies,
          cachedRates: cachedRates,
          fromCode: state.fromCode.isEmpty
              ? _pickCode(currencies, preferredFromCode, 0)
              : state.fromCode,
          toCode: state.toCode.isEmpty
              ? _pickCode(currencies, preferredToCode, 1)
              : state.toCode,
        ),
      ),
    );
  }

  ConverterState _withValidSelection(ConverterState next) {
    final fromCode = _validCode(next.fromCurrencies, next.fromCode);
    final withFrom = next.copyWith(fromCode: fromCode);
    final toCode = _validCode(
      withFrom.toCurrencies
          .where((currency) => currency.code != fromCode)
          .toList(),
      withFrom.toCode,
    );
    final selected = withFrom.copyWith(toCode: toCode);
    final isSelectionChanged = selected.fromCode != state.fromCode ||
        selected.toCode != state.toCode;
    return isSelectionChanged
        ? selected.copyWith(conversionState: GenericStates.initial)
        : selected;
  }

  String _validCode(List<Currency> currencies, String code) {
    if (currencies.isEmpty ||
        currencies.any((currency) => currency.code == code)) {
      return code;
    }
    return currencies.first.code;
  }

  String _pickCode(
    List<Currency> currencies,
    String preferred,
    int fallbackIndex,
  ) {
    if (currencies.isEmpty) return '';
    if (currencies.any((currency) => currency.code == preferred)) {
      return preferred;
    }
    final index = fallbackIndex < currencies.length ? fallbackIndex : 0;
    return currencies[index].code;
  }
}
