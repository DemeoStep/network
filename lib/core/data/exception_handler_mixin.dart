import 'package:network/core/data/result.dart';
import 'package:network/abstraction/api_client/api_client_exception.dart';
import 'package:network/core/exceptions/json_parse_exception.dart';
import 'package:network/core/exceptions/mapper_exception.dart';

mixin ExceptionHandlerMixin {
  Result<T> handleException<T>(dynamic e) {
    if (e is JsonParseException) {
      return Result.error(error: e);
    } else if (e is MapperException) {
      return Result.error(error: e);
    } else if (e is ApiClientException) {
      return Result.error(error: e);
    }
    return Result.error(error: Exception('Unexpected error: $e'));
  }
}
