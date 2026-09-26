part of 'api_consumer.dart';

const int _errorDetailMaxLength = 280;

String _errorHandler(DioException exception) {
  final data = exception.response?.data;
  String errorMessage;

  if (data is Map<String, dynamic>) {
    errorMessage = data['message'] as String? ??
        data['error'] as String? ??
        data.toString();
  } else if (data != null) {
    errorMessage = data.toString();
  } else {
    errorMessage = exception.response?.statusMessage ?? '';
  }

  final type = exception.type;

  switch (type) {
    case DioExceptionType.connectionTimeout:
      return 'Connection timeout: Please try again later';
    case DioExceptionType.badCertificate:
      return 'Secure connection could not be established. '
          'Please try again later.';
    case DioExceptionType.cancel:
      return 'Request cancelled: ${_truncateErrorDetail(errorMessage)}';
    case DioExceptionType.connectionError:
      return 'Connection error: ${_truncateErrorDetail(
        _preferNonEmpty(errorMessage, exception.error?.toString()),
      )}';
    case DioExceptionType.receiveTimeout:
      return 'Receive timeout: ${_truncateErrorDetail(errorMessage)}';
    case DioExceptionType.sendTimeout:
      return 'Send timeout: ${_truncateErrorDetail(errorMessage)}';
    case DioExceptionType.transformTimeout:
      return 'Transform timeout: ${_truncateErrorDetail(errorMessage)}';
    case DioExceptionType.badResponse:
      return mapBadResponseException(
        exception.response?.statusCode,
        errorMessage,
      );
    case DioExceptionType.unknown:
      final cause = _preferNonEmpty(
        exception.error?.toString(),
        exception.message,
      );
      if (cause.isNotEmpty) {
        return 'Unknown network error: ${_truncateErrorDetail(cause)}';
      }
      return 'Unknown network error: no details available';
  }
}

String mapBadResponseException(int? statusCode, String errorMessage) {
  final detail = errorMessage.trim().isEmpty ? 'no body' : errorMessage.trim();
  final truncated = _truncateErrorDetail(detail);
  switch (statusCode) {
    case 400:
      return 'Bad request: $truncated';
    case 404:
      return 'Not found: $truncated';
    case 422:
      return 'Unprocessable request: $truncated';
    case 429:
      return 'Too many requests: $truncated';
    case 500:
      return 'Internal server error: $truncated';
    case 502:
      return 'Bad gateway: $truncated';
    case 503:
      return 'Service unavailable: $truncated';
    case 504:
      return 'Gateway timeout: $truncated';
    default:
      final status = statusCode?.toString() ?? 'unknown';
      return 'HTTP $status: $truncated';
  }
}

String _preferNonEmpty(String? primary, String? fallback) {
  final a = primary?.trim() ?? '';
  if (a.isNotEmpty && a != 'null') {
    return a;
  }
  final b = fallback?.trim() ?? '';
  if (b.isNotEmpty && b != 'null') {
    return b;
  }
  return '';
}

String _truncateErrorDetail(String value) {
  final trimmed = value.trim();
  if (trimmed.length <= _errorDetailMaxLength) {
    return trimmed;
  }
  return trimmed.substring(0, _errorDetailMaxLength);
}
