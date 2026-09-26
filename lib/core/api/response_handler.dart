part of 'api_consumer.dart';

Either<Failure, dynamic> _responseHandler(Response<dynamic> response) {
  final data = response.data;
  if (data is Map<String, dynamic> && data['success'] == false) {
    return Left(
      NetworkFailure(
        message: _extractErrorMessage(data),
        statusCode: response.statusCode ?? 0,
      ),
    );
  }
  return Right(data);
}

String _extractErrorMessage(Map<String, dynamic> data) {
  return data['message'] as String? ??
      data['error'] as String? ??
      'Unknown error';
}
