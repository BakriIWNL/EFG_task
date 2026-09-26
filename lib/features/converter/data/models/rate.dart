import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rate.g.dart';

@JsonSerializable()
class Rate extends Equatable {
  const Rate({
    required this.date,
    required this.base,
    required this.quote,
    required this.rate,
  });

  factory Rate.fromJson(Map<String, dynamic> json) => _$RateFromJson(json);

  final DateTime date;
  final String base;
  final String quote;
  final double rate;

  Map<String, dynamic> toJson() => _$RateToJson(this);

  @override
  List<Object?> get props => [
        date,
        base,
        quote,
        rate,
      ];
}
