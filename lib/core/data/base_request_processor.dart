import 'package:injectable/injectable.dart';
import 'package:network/abstraction/api_client/api_response.dart';
import 'package:network/abstraction/request_processor.dart';
import 'package:network/abstraction/api_client/api_client_exception.dart';

///Custom function to provide request Future
typedef OnRequest<ApiResponse> = Future<ApiResponse> Function();

///Custom Function to provide response converter (Map to Object)
typedef OnParse<Result> = Result Function(ApiResponse response);

typedef OnCustomError<E> = E Function(int statusCode, ApiResponse response);

typedef CheckInternetConnection = Future<bool> Function();

//ignore: one_member_abstracts
@LazySingleton(as: RequestProcessor)
class BaseRequestProcessor implements RequestProcessor {
  @override
  Future<Result> processRequest<Result>({
    required OnRequest onRequest,
    required OnParse<Result> onParse,
    OnCustomError? onCustomRequestError,
    CheckInternetConnection? checkNetworkConnection,
  }) async {
    if (checkNetworkConnection != null) {
      final hasConnection = await checkNetworkConnection();
      if (!hasConnection) {
        throw ApiConnectionException();
      }
    }
    try {
      final response = await onRequest();
      return onParse(response);
    } catch (e) {
      if (onCustomRequestError != null) {
        // Call the custom error handler
        rethrow;
      } else {
        // Rethrow the original exception if no custom handler is provided
        rethrow;
      }
    }
  }
}
