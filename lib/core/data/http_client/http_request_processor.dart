import 'package:network/core/data/api_client/api_request_processor.dart';
import 'package:network/core/data/request_processor.dart';

class HttpRequestProcessor implements ApiRequestProcessor {
  @override
  Future<T> processRequest<T>({
    required Future<T> Function() onProcess,
    OnCustomError? onCustomError,
  }) async {
    try {
      return await onProcess();
    } catch (e) {
      throw Exception('Error processing request: $e');
    }
  }
}
