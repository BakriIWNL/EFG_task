import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.message,
    this.trace,
    required this.statusCode,
  });

  final String message;
  final StackTrace? trace;
  final int statusCode;

  @override
  List<Object?> get props => [
        message,
        trace,
        statusCode,
      ];
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, required super.statusCode});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.statusCode});
}
