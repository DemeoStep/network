import 'dart:io';

import 'package:dio/dio.dart' as http;
import 'package:network/core/data/api_client/api_request_processor.dart';
import 'package:network/core/data/request_processor.dart';
import 'package:network/core/exceptions/api_client_exception.dart';

class HttpRequestProcessor implements ApiRequestProcessor {
  @override
  Future<T> processRequest<T>({
    required Future<T> Function() onProcess,
    OnCustomError? onCustomError,
  }) async {
    try {
      final response = await onProcess();
      switch (response?.statusCode) {}
      return response;
    } on ArgumentError catch (e, stackTrace) {
      Error.throwWithStackTrace(
        ServerApiException(statusCode: HttpStatus.badRequest, response: null),
        stackTrace,
      );
    } catch (e, stackTrace) {
      rethrow;
      //Error.throwWithStackTrace(UnknownApiException(), stackTrace);
    }
  }
}
