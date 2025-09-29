import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:network/abstraction/api_client/api_request_processor.dart';
import 'package:network/abstraction/api_client/api_response.dart';
import 'package:network/abstraction/request_processor.dart';
import 'package:network/abstraction/api_client/api_client_exception.dart';

@LazySingleton()
class HttpRequestProcessor implements ApiRequestProcessor {
  @override
  Future<ApiResponse> processRequest({
    required Future<ApiResponse> Function() onProcess,
    OnCustomError? onCustomError,
  }) async {
    try {
      final response = await onProcess();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else if (onCustomError != null) {
        return onCustomError(response.statusCode, response);
      } else if (response.statusCode == HttpStatus.requestTimeout ||
          response.statusCode == HttpStatus.connectionClosedWithoutResponse ||
          response.statusCode == HttpStatus.clientClosedRequest) {
        throw ApiConnectionException();
      } else {
        throw ServerApiException(
          statusCode: response.statusCode,
          response: response,
        );
      }
    } on ArgumentError catch (e, stackTrace) {
      Error.throwWithStackTrace(
        ServerApiException(statusCode: HttpStatus.badRequest, response: null),
        stackTrace,
      );
    } catch (e, stackTrace) {
      if (e is ApiClientException) {
        Error.throwWithStackTrace(e, stackTrace);
      }

      ApiClientException exception = UnknownApiException();
      switch (e) {
        case http.ClientException _:
          exception = ApiConnectionException(message: e.message);
        case SocketException _:
          exception = ApiConnectionException(message: e.message);
      }
      Error.throwWithStackTrace(exception, stackTrace);
    }
  }
}
