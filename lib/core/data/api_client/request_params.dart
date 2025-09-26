import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

abstract class RequestParams<T> {}

class DioRequestParams implements RequestParams<Dio> {
  final Map<String, dynamic>? queryParameters;
  final Options? options;
  final CancelToken? cancelToken;
  final void Function(int, int)? onSendProgress;
  final void Function(int, int)? onReceiveProgress;

  DioRequestParams({
    this.queryParameters,
    this.options,
    this.cancelToken,
    this.onSendProgress,
    this.onReceiveProgress,
  });
}

class HttpRequestParams implements RequestParams<http.Client> {
  final Map<String, String>? headers;
  final Encoding? encoding;

  HttpRequestParams({this.headers, this.encoding});
}
