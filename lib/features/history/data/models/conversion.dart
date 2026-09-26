import 'package:efg_currency_converter/features/converter/data/models/exchange_rates.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conversion.g.dart';

@JsonSerializable()
class Conversion extends Equatable {
  const Conversion({
    required this.id,
    required this.amount,
    required this.fromCode,
    required this.toCode,
    required this.fromSymbol,
    required this.toSymbol,
    required this.rate,
    required this.convertedAmount,
    required this.rateDate,
    required this.updatedAt,
    required this.createdAt,
    this.isOutdated = false,
  });

  factory Conversion.fromRates({
    required double amount,
    required String fromCode,
    required String toCode,
    required String fromSymbol,
    required String toSymbol,
    required ExchangeRates rates,
    required DateTime createdAt,
    required bool isOutdated,
  }) {
    final rate = rates.rateFor(toCode) ?? 0;
    return Conversion(
      id: createdAt.microsecondsSinceEpoch.toString(),
      amount: amount,
      fromCode: fromCode,
      toCode: toCode,
      fromSymbol: fromSymbol,
      toSymbol: toSymbol,
      rate: rate,
      convertedAmount: amount * rate,
      rateDate: rates.date,
      updatedAt: rates.updatedAt,
      createdAt: createdAt,
      isOutdated: isOutdated,
    );
  }

  factory Conversion.fromJson(Map<String, dynamic> json) =>
      _$ConversionFromJson(json);

  final String id;
  final double amount;
  final String fromCode;
  final String toCode;
  final String fromSymbol;
  final String toSymbol;
  final double rate;
  final double convertedAmount;
  final DateTime rateDate;
  final DateTime updatedAt;
  final DateTime createdAt;
  final bool isOutdated;

  Conversion recalculate({
    required ExchangeRates rates,
    required bool isOutdated,
  }) {
    final newRate = rates.rateFor(toCode) ?? rate;
    return copyWith(
      rate: newRate,
      convertedAmount: amount * newRate,
      rateDate: rates.date,
      updatedAt: rates.updatedAt,
      isOutdated: isOutdated,
    );
  }

  Conversion copyWith({
    String? id,
    double? amount,
    String? fromCode,
    String? toCode,
    String? fromSymbol,
    String? toSymbol,
    double? rate,
    double? convertedAmount,
    DateTime? rateDate,
    DateTime? updatedAt,
    DateTime? createdAt,
    bool? isOutdated,
  }) {
    return Conversion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      fromCode: fromCode ?? this.fromCode,
      toCode: toCode ?? this.toCode,
      fromSymbol: fromSymbol ?? this.fromSymbol,
      toSymbol: toSymbol ?? this.toSymbol,
      rate: rate ?? this.rate,
      convertedAmount: convertedAmount ?? this.convertedAmount,
      rateDate: rateDate ?? this.rateDate,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      isOutdated: isOutdated ?? this.isOutdated,
    );
  }

  Map<String, dynamic> toJson() => _$ConversionToJson(this);

  @override
  List<Object?> get props => [
        id,
        amount,
        fromCode,
        toCode,
        fromSymbol,
        toSymbol,
        rate,
        convertedAmount,
        rateDate,
        updatedAt,
        createdAt,
        isOutdated,
      ];
}
