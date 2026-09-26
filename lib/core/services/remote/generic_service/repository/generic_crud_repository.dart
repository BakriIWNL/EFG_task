import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:efg_currency_converter/core/error/failure.dart';

abstract class GenericCrudRepository<S> {
  Future<Either<Failure, R>> add<R>({
    Object? body,
    Map<String, dynamic>? queryParameters,
    required String apiPath,
    FormData? formData,
    Options? options,
    required R Function(S json) dataMapper,
  });

  Future<Either<Failure, R>> update<R>({
    Object? body,
    Map<String, dynamic>? queryParameters,
    required String apiPath,
    required R Function(S json) dataMapper,
  });

  Future<Either<Failure, R>> delete<R>({
    Map<String, dynamic>? queryParameters,
    required String apiPath,
    required R Function(S json) dataMapper,
  });

  Future<Either<Failure, R>> get<R>({
    required String apiPath,
    required R Function(S json) dataMapper,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Options? options,
  });
}
