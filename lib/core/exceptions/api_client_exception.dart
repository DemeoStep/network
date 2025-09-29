abstract class ApiClientException implements Exception {
  final String message;

  ApiClientException({required this.message});
}

class ApiConnectionException extends ApiClientException {
  ApiConnectionException() : super(message: 'Connection timeout');
}

class ServerApiException extends ApiClientException {
  final int statusCode;
  final Object? response;

  ServerApiException({required this.statusCode, this.response})
    : super(message: 'Server error: $statusCode');
}

class UnknownApiException extends ApiClientException {
  UnknownApiException({Object? response}) : super(message: 'Unknown error');
}

class RequestCancelledException extends ApiClientException {
  RequestCancelledException() : super(message: 'Request cancelled');
}

class BadCertificateException extends ApiClientException {
  BadCertificateException() : super(message: 'Bad certificate');
}
