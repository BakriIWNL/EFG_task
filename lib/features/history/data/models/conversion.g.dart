// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversion _$ConversionFromJson(Map<String, dynamic> json) => Conversion(
  id: json['id'] as String,
  amount: (json['amount'] as num).toDouble(),
  fromCode: json['fromCode'] as String,
  toCode: json['toCode'] as String,
  fromSymbol: json['fromSymbol'] as String,
  toSymbol: json['toSymbol'] as String,
  rate: (json['rate'] as num).toDouble(),
  convertedAmount: (json['convertedAmount'] as num).toDouble(),
  rateDate: DateTime.parse(json['rateDate'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  isOutdated: json['isOutdated'] as bool? ?? false,
);

Map<String, dynamic> _$ConversionToJson(Conversion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'fromCode': instance.fromCode,
      'toCode': instance.toCode,
      'fromSymbol': instance.fromSymbol,
      'toSymbol': instance.toSymbol,
      'rate': instance.rate,
      'convertedAmount': instance.convertedAmount,
      'rateDate': instance.rateDate.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'isOutdated': instance.isOutdated,
    };
