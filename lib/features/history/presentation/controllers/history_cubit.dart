import 'package:efg_currency_converter/core/utils/enums.dart';
import 'package:efg_currency_converter/features/converter/data/models/exchange_rates.dart';
import 'package:efg_currency_converter/features/converter/data/repositories/local/local_converter_repository.dart';
import 'package:efg_currency_converter/features/converter/data/repositories/remote/converter_repository.dart';
import 'package:efg_currency_converter/features/history/data/models/conversion.dart';
import 'package:efg_currency_converter/features/history/data/repositories/local/local_history_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(
    this._repository,
    this._localRepository,
    this._localHistoryRepository,
  ) : super(const HistoryState());

  final ConverterRepository _repository;
  final LocalConverterRepository _localRepository;
  final LocalHistoryRepository _localHistoryRepository;

  Future<void> getHistory() async {
    if (state.state != GenericStates.success) {
      emit(state.copyWith(state: GenericStates.loading));
    }
    final conversions = await _localHistoryRepository.getConversions();
    if (isClosed) return;
    emit(
      state.copyWith(
        state: GenericStates.success,
        conversions: conversions,
      ),
    );
  }

  Future<void> cacheRates(ExchangeRates rates) async {
    await _localRepository.cacheRates(rates);
  }

  Future<void> recalculate(Conversion conversion) async {
    if (state.recalculatingIds.contains(conversion.id)) return;
    emit(
      state.copyWith(
        recalculatingIds: [...state.recalculatingIds, conversion.id],
        recalculateState: GenericStates.loading,
      ),
    );

    final result = await _repository.getRates(conversion.fromCode);
    await result.fold(
      (failure) async {
        final cachedRates = await _localRepository.getCachedRates();
        final rates = cachedRates[conversion.fromCode];
        if (rates == null || rates.rateFor(conversion.toCode) == null) {
          _finishRecalculation(
            conversion.id,
            recalculateState: GenericStates.error,
            errorMessage: failure.message,
          );
          return;
        }
        await _updateConversion(
          conversion.recalculate(rates: rates, isOutdated: true),
        );
      },
      (rates) async {
        await cacheRates(rates);
        if (rates.rateFor(conversion.toCode) == null) {
          _finishRecalculation(
            conversion.id,
            recalculateState: GenericStates.error,
            errorMessage: 'No rate is available for ${conversion.fromCode} '
                'to ${conversion.toCode}.',
          );
          return;
        }
        await _updateConversion(
          conversion.recalculate(rates: rates, isOutdated: false),
        );
      },
    );
  }

  Future<void> deleteConversion(Conversion conversion) async {
    final previous = state.conversions;
    emit(
      state.copyWith(
        conversions:
            previous.where((item) => item.id != conversion.id).toList(),
        deleteState: GenericStates.loading,
      ),
    );
    final isDeleted =
        await _localHistoryRepository.deleteConversion(conversion.id);
    if (isClosed) return;
    emit(
      state.copyWith(
        conversions: isDeleted ? state.conversions : previous,
        deleteState: isDeleted ? GenericStates.success : GenericStates.error,
        deletedConversion: conversion,
      ),
    );
  }

  Future<void> restoreConversion(Conversion conversion) async {
    final isSaved = await _localHistoryRepository.saveConversion(conversion);
    if (isSaved) {
      await getHistory();
    }
  }

  Future<void> clearHistory() async {
    final previous = state.conversions;
    emit(
      state.copyWith(
        conversions: const [],
        clearState: GenericStates.loading,
      ),
    );
    final isCleared = await _localHistoryRepository.clearConversions();
    if (isClosed) return;
    emit(
      state.copyWith(
        conversions: isCleared ? const [] : previous,
        clearState: isCleared ? GenericStates.success : GenericStates.error,
      ),
    );
  }

  Future<void> _updateConversion(Conversion conversion) async {
    final isStillSaved =
        state.conversions.any((item) => item.id == conversion.id);
    if (!isStillSaved) {
      _finishRecalculation(
        conversion.id,
        recalculateState: GenericStates.initial,
      );
      return;
    }
    final isSaved = await _localHistoryRepository.saveConversion(conversion);
    if (isClosed) return;
    if (!isSaved) {
      _finishRecalculation(
        conversion.id,
        recalculateState: GenericStates.error,
      );
      return;
    }
    emit(
      state.copyWith(
        conversions: [
          for (final item in state.conversions)
            item.id == conversion.id ? conversion : item,
        ],
        recalculatingIds: _withoutId(conversion.id),
        recalculateState: GenericStates.success,
        recalculatedConversion: conversion,
      ),
    );
  }

  void _finishRecalculation(
    String id, {
    required GenericStates recalculateState,
    String errorMessage = '',
  }) {
    if (isClosed) return;
    emit(
      state.copyWith(
        recalculatingIds: _withoutId(id),
        recalculateState: recalculateState,
        errorMessage: errorMessage,
      ),
    );
  }

  List<String> _withoutId(String id) {
    return state.recalculatingIds.where((item) => item != id).toList();
  }
}
