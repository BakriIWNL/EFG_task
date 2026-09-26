import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:efg_currency_converter/core/api/api_constants.dart';
import 'package:efg_currency_converter/core/api/dio_consumer.dart';
import 'package:efg_currency_converter/core/api/interceptors/retry_interceptor.dart';
import 'package:efg_currency_converter/core/error/failure.dart';
import 'package:flutter/foundation.dart';

part 'error_handler.dart';
part 'response_handler.dart';

class ApiConsumer extends DioConsumer {
  ApiConsumer({
    required this.dio,
  });

  final Dio dio;

  void initialize() {
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      receiveTimeout: const Duration(seconds: ApiConstants.receiveTimeout),
      connectTimeout: const Duration(seconds: ApiConstants.connectTimeout),
      sendTimeout: const Duration(seconds: ApiConstants.sendTimeout),
    );
    dio.interceptors.addAll([
      RetryInterceptor(dio: dio),
      if (kDebugMode)
        LogInterceptor(
          requestHeader: false,
          responseHeader: false,
          logPrint: (object) => debugPrint(object.toString()),
        ),
    ]);
  }

  @override
  Future<Either<Failure, dynamic>> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.get(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      final result = _responseHandler(response);
      return result;
    } on DioException catch (exception) {
      return Left(
        NetworkFailure(
          message: _errorHandler(exception),
          statusCode: exception.response?.statusCode ?? 0,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, dynamic>> post(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    FormData? formData,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.post(
        uri,
        queryParameters: queryParameters,
        data: data ?? formData,
        options: options,
        cancelToken: cancelToken,
      );
      final result = _responseHandler(response);
      return result;
    } on DioException catch (exception) {
      return Left(
        NetworkFailure(
          message: _errorHandler(exception),
          statusCode: exception.response?.statusCode ?? 0,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, dynamic>> put(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    FormData? formData,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.put(
        uri,
        queryParameters: queryParameters,
        data: data ?? formData,
        options: options,
        cancelToken: cancelToken,
      );
      final result = _responseHandler(response);
      return result;
    } on DioException catch (exception) {
      return Left(
        NetworkFailure(
          message: _errorHandler(exception),
          statusCode: exception.response?.statusCode ?? 0,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, dynamic>> delete(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.delete(
        uri,
        queryParameters: queryParameters,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );
      final result = _responseHandler(response);
      return result;
    } on DioException catch (exception) {
      return Left(
        NetworkFailure(
          message: _errorHandler(exception),
          statusCode: exception.response?.statusCode ?? 0,
        ),
      );
    }
  }
}
