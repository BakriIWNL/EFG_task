// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rate _$RateFromJson(Map<String, dynamic> json) => Rate(
  date: DateTime.parse(json['date'] as String),
  base: json['base'] as String,
  quote: json['quote'] as String,
  rate: (json['rate'] as num).toDouble(),
);

Map<String, dynamic> _$RateToJson(Rate instance) => <String, dynamic>{
  'date': instance.date.toIso8601String(),
  'base': instance.base,
  'quote': instance.quote,
  'rate': instance.rate,
};
