import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:efg_currency_converter/core/error/failure.dart';

abstract class DioConsumer<T> {
  Future<Either<Failure, T>> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
  });

  Future<Either<Failure, T>> post(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    FormData? formData,
    Options? options,
    CancelToken? cancelToken,
  });

  Future<Either<Failure, T>> put(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    FormData? formData,
    Options? options,
    CancelToken? cancelToken,
  });

  Future<Either<Failure, T>> delete(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
  });
}
