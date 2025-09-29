import 'package:injectable/injectable.dart';
import 'package:network/core/exceptions/api_client_exception.dart';
import 'package:network/core/exceptions/json_parse_exception.dart';

///Custom function to provide request Future
typedef OnRequest<T> = Future<T> Function();

///Custom Function to provide response converter (Map to Object)
typedef OnParse<T> = T Function(dynamic response);

typedef OnCustomError<T> = T Function(int statusCode, dynamic response);

//ignore: one_member_abstracts
@LazySingleton()
class RequestProcessor {
  Future<R> processRequest<T, R>({
    required OnRequest<T> onRequest,
    required OnParse<R> onParse,
    OnCustomError? onCustomRequestError,
    bool checkNetworkConnection = true,
  }) async {
    // Implement connection check if needed
    try {
      final response = await onRequest();
      return onParse(response);
    } on ApiClientException catch (e) {
      if (onCustomRequestError != null) {
        // Call the custom error handler
        rethrow;
      } else {
        // Rethrow the original exception if no custom handler is provided
        rethrow;
      }
    } on JsonParseException catch (e) {
      rethrow;
    } catch (e) {
      // Handle errors and possibly use onCustomRequestError
      rethrow;
    }
  }
}
