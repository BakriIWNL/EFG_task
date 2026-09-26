import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:efg_currency_converter/core/api/dio_consumer.dart';
import 'package:efg_currency_converter/core/error/failure.dart';
import 'package:efg_currency_converter/core/services/remote/generic_service/repository/generic_crud_repository.dart';

class GenericCrudDataSource<T, S> implements GenericCrudRepository {
  const GenericCrudDataSource(this._client);

  final DioConsumer _client;

  @override
  Future<Either<Failure, R>> add<R>({
    Object? body,
    Map<String, dynamic>? queryParameters,
    required String apiPath,
    FormData? formData,
    Options? options,
    required R Function(S json) dataMapper,
  }) async {
    final result = await _client.post(
      apiPath,
      formData: formData,
      options: options,
      data: body,
      queryParameters: queryParameters,
    );
    return _handleResponse(result, dataMapper);
  }

  @override
  Future<Either<Failure, R>> delete<R>({
    Map<String, dynamic>? queryParameters,
    required String apiPath,
    required R Function(S json) dataMapper,
  }) async {
    final result =
        await _client.delete(apiPath, queryParameters: queryParameters);
    return _handleResponse(result, dataMapper);
  }

  @override
  Future<Either<Failure, R>> get<R>({
    required String apiPath,
    required R Function(S json) dataMapper,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Options? options,
  }) async {
    final result = await _client.get(
      apiPath,
      queryParameters: queryParameters,
      data: body,
      options: options,
    );
    return _handleResponse(result, dataMapper);
  }

  @override
  Future<Either<Failure, R>> update<R>({
    Object? body,
    Map<String, dynamic>? queryParameters,
    required String apiPath,
    required R Function(S json) dataMapper,
  }) async {
    final result = await _client.put(
      apiPath,
      data: body,
      queryParameters: queryParameters,
    );
    return _handleResponse(result, dataMapper);
  }

  Either<Failure, R> _handleResponse<R>(
    Either<Failure, dynamic> result,
    R Function(S json) dataMapper,
  ) {
    return result.fold(
      (error) => Left(
        NetworkFailure(
          message: error.message,
          statusCode: error.statusCode,
        ),
      ),
      (response) {
        try {
          return Right(dataMapper(response));
        } on FormatException catch (e) {
          return Left(
            NetworkFailure(
              message: e.message,
              statusCode: 422,
            ),
          );
        } on Object catch (e) {
          return Left(
            NetworkFailure(
              message: e.toString(),
              statusCode: 422,
            ),
          );
        }
      },
    );
  }
}
