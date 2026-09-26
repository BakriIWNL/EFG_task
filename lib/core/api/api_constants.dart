mixin ApiConstants {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.frankfurter.dev',
  );

  static const int receiveTimeout = 15;
  static const int connectTimeout = 10;
  static const int sendTimeout = 10;
}
