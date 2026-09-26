import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this.dio,
    this.maxRetries = 1,
    this.retryDelay = const Duration(seconds: 1),
  });

  static const String _retryCountKey = 'retryCount';
  static const Set<String> _idempotentMethods = {
    'GET',
    'HEAD',
    'PUT',
    'DELETE',
    'OPTIONS',
  };

  final Dio dio;
  final int maxRetries;
  final Duration retryDelay;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final retryCount = (options.extra[_retryCountKey] as int?) ?? 0;

    if (!_shouldRetry(err) || retryCount >= maxRetries) {
      handler.next(err);
      return;
    }

    await Future<void>.delayed(retryDelay * (retryCount + 1));
    options.extra[_retryCountKey] = retryCount + 1;

    try {
      final response = await dio.fetch<dynamic>(options);
      handler.resolve(response);
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  bool _shouldRetry(DioException err) {
    final method = err.requestOptions.method.toUpperCase();
    if (!_idempotentMethods.contains(method)) {
      return false;
    }

    final statusCode = err.response?.statusCode;
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        (statusCode != null && statusCode >= 500);
  }
}
