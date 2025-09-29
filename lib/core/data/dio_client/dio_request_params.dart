import 'package:dio/dio.dart';
import 'package:network/abstraction/request_params.dart';

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
