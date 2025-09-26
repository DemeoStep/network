import 'package:network/core/exceptions/mapper_exception.dart';

abstract class Mapper<F, T> {
  T _map(F from);

  T tryMap(F from) {
    try {
      return _map(from);
    } catch (e) {
      throw MapperException('Failed to map $F to $T: $e');
    }
  }
}
