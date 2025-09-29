import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:network/core/data/api_client/api_request_processor.dart';
import 'package:network/core/data/api_client/api_response.dart';
import 'package:network/core/data/request_processor.dart';
import 'package:network/core/exceptions/api_client_exception.dart';

@LazySingleton()
class HttpRequestProcessor implements ApiRequestProcessor {
  @override
  Future<ApiResponse> processRequest({
    required Future<ApiResponse> Function() onProcess,
    OnCustomError? onCustomError,
  }) async {
    try {
      final response = await onProcess();
      switch (response.statusCode) {}
      return response;
    } on ArgumentError catch (e, stackTrace) {
      Error.throwWithStackTrace(
        ServerApiException(statusCode: HttpStatus.badRequest, response: null),
        stackTrace,
      );
    } catch (e, stackTrace) {
      ApiClientException exception = UnknownApiException();
      switch (e) {
        case http.ClientException _:
          exception = ApiConnectionException(message: e.message);
      }
      Error.throwWithStackTrace(exception, stackTrace);
    }
  }
}
