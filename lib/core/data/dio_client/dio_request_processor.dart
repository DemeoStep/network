import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:network/core/data/api_client/api_request_processor.dart';
import 'package:network/core/data/api_client/api_response.dart';
import 'package:network/core/data/request_processor.dart';
import 'package:network/core/exceptions/api_client_exception.dart';

@LazySingleton()
class DioRequestProcessor implements ApiRequestProcessor {
  @override
  Future<ApiResponse> processRequest({
    required Future<ApiResponse> Function() onProcess,
    OnCustomError? onCustomError,
  }) async {
    try {
      return await onProcess();
    } on DioException catch (e, stackTrace) {
      if (onCustomError != null) {
        final response = ApiResponse(
          body: e.response?.data,
          statusCode: e.response?.statusCode ?? -1,
          headers:
              e.response?.headers.map.map(
                (key, value) => MapEntry(key, value.join(',')),
              ) ??
              {},
          isRedirect: e.response?.isRedirect ?? false,
        );

        return onCustomError(e.response?.statusCode ?? -1, response);
      }

      final exception = switch (e.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.connectionError => ApiConnectionException(),
        DioExceptionType.cancel => RequestCancelledException(),
        DioExceptionType.badCertificate => BadCertificateException(),
        DioExceptionType.badResponse || DioExceptionType.unknown =>
          (e.response != null && e.response?.statusCode != null)
              ? ServerApiException(
                  statusCode: e.response!.statusCode!,
                  response: e.response,
                )
              : UnknownApiException(),
      };

      Error.throwWithStackTrace(exception, stackTrace);
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(UnknownApiException(), stackTrace);
    }
  }
}
