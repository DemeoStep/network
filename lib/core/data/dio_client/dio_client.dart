import 'package:dio/dio.dart';
import 'package:network/abstraction/api_client/api_client.dart';
import 'package:network/abstraction/api_client/api_response.dart';
import 'package:network/abstraction/request_params.dart';
import 'package:network/core/data/dio_client/dio_request_params.dart';
import 'package:network/core/data/dio_client/dio_request_processor.dart';
import 'package:network/abstraction/request_processor.dart';

class DioClient implements ApiClient<Dio> {
  final Dio _client;
  final DioRequestProcessor _requestProcessor;

  DioClient(this._client, this._requestProcessor);

  @override
  Future<ApiResponse> get(
    String path, {
    Object? data,
    OnCustomError? onCustomError,
    RequestParams? requestParams,
  }) async {
    return await _requestProcessor.processRequest(
      onProcess: () async {
        final params = requestParams as DioRequestParams?;
        final result = await _client.get(
          path,
          data: data,
          queryParameters: params?.queryParameters,
          options: params?.options,
          cancelToken: params?.cancelToken,
          onReceiveProgress: params?.onReceiveProgress,
        );
        return _toApiResponse(result);
      },
      onCustomError: onCustomError,
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
        final params = requestParams as DioRequestParams?;
        final response = await _client.post(
          path,
          data: data,
          queryParameters: params?.queryParameters,
          options: params?.options,
          cancelToken: params?.cancelToken,
          onSendProgress: params?.onSendProgress,
          onReceiveProgress: params?.onReceiveProgress,
        );
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
        final params = requestParams as DioRequestParams?;
        final response = await _client.put(
          path,
          data: data,
          queryParameters: params?.queryParameters,
          options: params?.options,
          cancelToken: params?.cancelToken,
          onSendProgress: params?.onSendProgress,
          onReceiveProgress: params?.onReceiveProgress,
        );
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
        final params = requestParams as DioRequestParams?;
        final response = await _client.delete(
          path,
          data: data,
          queryParameters: params?.queryParameters,
          options: params?.options,
          cancelToken: params?.cancelToken,
        );
        return _toApiResponse(response);
      },
    );
  }

  void attachInterceptors() {
    // client.interceptors.add(YourCustomInterceptor());
  }

  void deAttachInterceptors() {
    _client.interceptors.clear();
  }

  void attachLoggerInterceptor() {
    _client.interceptors.add(
      LogInterceptor(responseBody: true, requestBody: true),
    );
  }

  ApiResponse _toApiResponse(Response response) {
    return ApiResponse(
      body: response.data,
      statusCode: response.statusCode ?? 0,
      headers: response.headers.map.map(
        (key, value) => MapEntry(key, value.join(',')),
      ),
      isRedirect: response.isRedirect,
    );
  }
}
