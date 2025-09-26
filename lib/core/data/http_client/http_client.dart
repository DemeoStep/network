import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:network/core/data/api_client/api_client.dart';
import 'package:network/core/data/api_client/api_request_processor.dart';
import 'package:network/core/data/api_client/api_response.dart';
import 'package:network/core/data/api_client/request_params.dart';
import 'package:network/core/data/request_processor.dart';
import 'package:network/core/exceptions/api_client_exception.dart';

class HttpClient implements ApiClient<http.Client> {
  final http.Client _client;
  final ApiRequestProcessor _requestProcessor;

  HttpClient(this._client, this._requestProcessor);

  @override
  Future<ApiResponse> get(
    String path, {
    Object? data,
    OnCustomError? onCustomError,
    RequestParams? requestParams,
  }) async {
    return await _requestProcessor.processRequest(
      onProcess: () async {
        final result = await _client.get(Uri.parse(path));
        return _toApiResponse(result);
      },
    );
  }

  @override
  Future<ApiResponse> post(
    String path, {
    Object? data,
    OnCustomError? onCustomError,
    RequestParams? requestParams,
  }) async {
    return await _requestProcessor.processRequest(
      onProcess: () async {
        final response = await _client.post(Uri.parse(path), body: data);
        return _toApiResponse(response);
      },
    );
  }

  @override
  Future<ApiResponse> put(
    String path, {
    Object? data,
    OnCustomError? onCustomError,
    RequestParams? requestParams,
  }) async {
    return await _requestProcessor.processRequest(
      onProcess: () async {
        final response = await _client.put(Uri.parse(path), body: data);
        return _toApiResponse(response);
      },
    );
  }

  @override
  Future<ApiResponse> delete(
    String path, {
    Object? data,
    OnCustomError? onCustomError,
    RequestParams? requestParams,
  }) async {
    return await _requestProcessor.processRequest(
      onProcess: () async {
        final response = await _client.delete(Uri.parse(path), body: data);
        return _toApiResponse(response);
      },
    );
  }

  ApiResponse _toApiResponse(dynamic response) {
    if (response is! http.Response) {
      throw ApiClientException(
        message:
            'Expected a http.Response object, but got ${response.runtimeType}',
        type: ApiClientExceptionType.unknown,
      );
    }

    return ApiResponse(
      body: response.body,
      statusCode: response.statusCode,
      headers: response.headers,
      isRedirect: response.isRedirect,
    );
  }
}
