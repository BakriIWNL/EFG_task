// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_rates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeRates _$ExchangeRatesFromJson(Map<String, dynamic> json) =>
    ExchangeRates(
      base: json['base'] as String,
      date: DateTime.parse(json['date'] as String),
      rates: (json['rates'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ExchangeRatesToJson(ExchangeRates instance) =>
    <String, dynamic>{
      'base': instance.base,
      'date': instance.date.toIso8601String(),
      'rates': instance.rates,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
