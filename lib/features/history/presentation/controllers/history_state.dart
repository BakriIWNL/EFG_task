part of 'history_cubit.dart';

class HistoryState extends Equatable {
  const HistoryState({
    this.state = GenericStates.initial,
    this.recalculateState = GenericStates.initial,
    this.deleteState = GenericStates.initial,
    this.clearState = GenericStates.initial,
    this.conversions = const [],
    this.recalculatingIds = const [],
    this.recalculatedConversion,
    this.deletedConversion,
    this.errorMessage = '',
  });

  final GenericStates state;
  final GenericStates recalculateState;
  final GenericStates deleteState;
  final GenericStates clearState;
  final List<Conversion> conversions;
  final List<String> recalculatingIds;
  final Conversion? recalculatedConversion;
  final Conversion? deletedConversion;
  final String errorMessage;

  HistoryState copyWith({
    GenericStates? state,
    GenericStates? recalculateState,
    GenericStates? deleteState,
    GenericStates? clearState,
    List<Conversion>? conversions,
    List<String>? recalculatingIds,
    Conversion? recalculatedConversion,
    Conversion? deletedConversion,
    String? errorMessage,
  }) {
    return HistoryState(
      state: state ?? this.state,
      recalculateState: recalculateState ?? this.recalculateState,
      deleteState: deleteState ?? this.deleteState,
      clearState: clearState ?? this.clearState,
      conversions: conversions ?? this.conversions,
      recalculatingIds: recalculatingIds ?? this.recalculatingIds,
      recalculatedConversion:
          recalculatedConversion ?? this.recalculatedConversion,
      deletedConversion: deletedConversion ?? this.deletedConversion,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        state,
        recalculateState,
        deleteState,
        clearState,
        conversions,
        recalculatingIds,
        recalculatedConversion,
        deletedConversion,
        errorMessage,
      ];
}
