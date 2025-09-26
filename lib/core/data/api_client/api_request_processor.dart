import 'package:network/core/data/request_processor.dart';

abstract interface class ApiRequestProcessor {
  Future<T> processRequest<T>({
    required Future<T> Function() onProcess,
    OnCustomError? onCustomError,
  });
}
