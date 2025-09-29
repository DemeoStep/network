import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:network/abstraction/request_params.dart';

class HttpRequestParams implements RequestParams<http.Client> {
  final Map<String, String>? headers;
  final Encoding? encoding;

  HttpRequestParams({this.headers, this.encoding});
}
