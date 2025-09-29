import 'package:network/core/data/api_client/api_response.dart';
import 'package:network/core/data/request_processor.dart';

abstract interface class ApiRequestProcessor {
  Future<ApiResponse> processRequest({
    required Future<ApiResponse> Function() onProcess,
    OnCustomError? onCustomError,
  });
}
