import 'package:efg_currency_converter/features/converter/data/models/rate.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exchange_rates.g.dart';

@JsonSerializable()
class ExchangeRates extends Equatable {
  const ExchangeRates({
    required this.base,
    required this.date,
    required this.rates,
    required this.updatedAt,
  });

  factory ExchangeRates.fromRates({
    required String base,
    required List<Rate> rates,
    required DateTime updatedAt,
  }) {
    if (rates.isEmpty) {
      throw const FormatException('No exchange rates were returned.');
    }
    final latest = rates
        .map((rate) => rate.date)
        .reduce((current, next) => next.isAfter(current) ? next : current);
    return ExchangeRates(
      base: base.toUpperCase(),
      date: latest,
      rates: {for (final rate in rates) rate.quote: rate.rate},
      updatedAt: updatedAt,
    );
  }

  factory ExchangeRates.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRatesFromJson(json);

  final String base;
  final DateTime date;
  final Map<String, double> rates;
  final DateTime updatedAt;

  double? rateFor(String quote) => quote == base ? 1 : rates[quote];

  Map<String, dynamic> toJson() => _$ExchangeRatesToJson(this);

  @override
  List<Object?> get props => [
        base,
        date,
        rates,
        updatedAt,
      ];
}
