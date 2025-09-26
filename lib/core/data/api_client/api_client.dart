import 'package:network/core/data/api_client/api_response.dart';
import 'package:network/core/data/api_client/request_params.dart';
import 'package:network/core/data/request_processor.dart';

abstract interface class ApiClient<T> {
  Future<ApiResponse> get(
    String path, {
    Object? data,
    OnCustomError? onCustomError,
    RequestParams<T>? requestParams,
  });

  Future<ApiResponse> post(
    String path, {
    Object? data,
    OnCustomError? onCustomError,
    RequestParams<T>? requestParams,
  });

  Future<ApiResponse> put(
    String path, {
    Object? data,
    OnCustomError? onCustomError,
    RequestParams<T>? requestParams,
  });

  Future<ApiResponse> delete(
    String path, {
    Object? data,
    OnCustomError? onCustomError,
    RequestParams<T>? requestParams,
  });
}
