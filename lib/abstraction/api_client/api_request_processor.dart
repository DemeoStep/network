import 'package:network/abstraction/api_client/api_response.dart';
import 'package:network/abstraction/request_processor.dart';

abstract interface class ApiRequestProcessor {
  Future<ApiResponse> processRequest({
    required Future<ApiResponse> Function() onProcess,
    OnCustomError? onCustomError,
  });
}
