import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'currency.g.dart';

@JsonSerializable()
class Currency extends Equatable {
  const Currency({
    required this.code,
    required this.name,
    this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);

  @JsonKey(name: 'iso_code')
  final String code;
  final String name;
  final String? symbol;

  String get displaySymbol {
    final value = symbol?.trim() ?? '';
    return value.isEmpty ? code : value;
  }

  Map<String, dynamic> toJson() => _$CurrencyToJson(this);

  @override
  List<Object?> get props => [
        code,
        name,
        symbol,
      ];
}
