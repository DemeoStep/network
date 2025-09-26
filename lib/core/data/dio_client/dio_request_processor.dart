import 'package:dio/dio.dart';
import 'package:network/core/data/api_client/api_request_processor.dart';
import 'package:network/core/data/error_processor/error_processor.dart';
import 'package:network/core/data/request_processor.dart';
import 'package:network/core/exceptions/api_client_exception.dart';

class DioRequestProcessor implements ApiRequestProcessor {
  @override
  Future<T> processRequest<T>({
    required Future<T> Function() onProcess,
    OnCustomError? onCustomError,
  }) async {
    try {
      return await onProcess();
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          throw ApiClientException(
            message: 'Connection timeout',
            type: ApiClientExceptionType.connectionTimeout,
            response: e.response,
          );
        case DioExceptionType.sendTimeout:
          throw ApiClientException(
            message: 'Send timeout',
            type: ApiClientExceptionType.sendTimeout,
            response: e.response,
          );
        case DioExceptionType.receiveTimeout:
          throw ApiClientException(
            message: 'Receive timeout',
            type: ApiClientExceptionType.receiveTimeout,
            response: e.response,
          );
        case DioExceptionType.cancel:
          throw ApiClientException(
            message: 'Request cancelled',
            type: ApiClientExceptionType.cancel,
            response: e.response,
          );
        case DioExceptionType.connectionError:
          throw ApiClientException(
            message: 'Connection error',
            type: ApiClientExceptionType.connectionError,
            response: e.response,
          );
        case DioExceptionType.badCertificate:
          throw ApiClientException(
            message: 'Bad certificate',
            type: ApiClientExceptionType.badCertificate,
          );
        case DioExceptionType.badResponse:
        case DioExceptionType.unknown:
          final exception = ApiClientException(
            message: 'Unknown error',
            type: ApiClientExceptionType.fromCode(e.response?.statusCode ?? -1),
            response: e.response,
          );
          if (exception.statusCode == -1) {
            throw exception;
          } else {
            throw ErrorProcessor().processError(
              exception,
              onCustomError: onCustomError,
            );
          }
      }
    } catch (e) {
      throw ApiClientException(
        message: 'Error processing request: $e',
        type: ApiClientExceptionType.unknown,
      );
    }
  }
}
