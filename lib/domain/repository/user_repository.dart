import 'package:network/core/data/result.dart';
import 'package:network/domain/entity/user_entity.dart';

abstract interface class UserRepository {
  Future<Result<List<UserEntity>>> getUsers();
}
