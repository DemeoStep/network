import 'package:network/core/data/request_processor.dart';
import 'package:network/core/exceptions/api_client_exception.dart';

class ErrorProcessor {
  const ErrorProcessor();

  ApiClientException processError(
    ApiClientException e, {
    OnCustomError? onCustomError,
  }) {
    if (onCustomError != null) {
      final customError = onCustomError(e.statusCode, e.response);
      if (customError is ApiClientException) {
        return customError;
      } else if (customError is Exception) {
        return ApiClientException(
          message: customError.toString(),
          type: ApiClientExceptionType.fromCode(e.statusCode),
          response: e.response,
        );
      } else {
        return ApiClientException(
          message: 'Unknown error',
          type: ApiClientExceptionType.unknown,
          response: e.response,
        );
      }
    }

    final type = ApiClientExceptionType.fromCode(e.statusCode);

    return ApiClientException(
      message: type.name,
      type: type,
      response: e.response,
    );
  }
}
