abstract class ApiClientException implements Exception {
  final String message;

  const ApiClientException({required this.message});

  @override
  String toString() => 'ApiClientException: $message';
}

class ApiConnectionException extends ApiClientException {
  const ApiConnectionException({String? message})
    : super(message: message ?? 'Connection timeout');

  @override
  String toString() => 'ApiConnectionException: $message';
}

class ServerApiException extends ApiClientException {
  final int statusCode;
  final Object? response;

  const ServerApiException({required this.statusCode, this.response})
    : super(message: 'Server error: $statusCode');

  @override
  String toString() => 'ServerApiException: $statusCode, response: $response';
}

class UnknownApiException extends ApiClientException {
  const UnknownApiException({Object? response})
    : super(message: 'Unknown error');

  @override
  String toString() => 'UnknownApiException: $message';
}

class RequestCancelledException extends ApiClientException {
  const RequestCancelledException() : super(message: 'Request cancelled');

  @override
  String toString() => 'RequestCancelledException: $message';
}

class BadCertificateException extends ApiClientException {
  const BadCertificateException() : super(message: 'Bad certificate');

  @override
  String toString() => 'BadCertificateException: $message';
}
