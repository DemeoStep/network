import 'package:injectable/injectable.dart';
import 'package:network/core/data/exception_handler_mixin.dart';
import 'package:network/core/data/result.dart';
import 'package:network/data/mapper/user_mapper.dart';
import 'package:network/data/source/user_source.dart';
import 'package:network/domain/entity/user_entity.dart';
import 'package:network/domain/repository/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl with ExceptionHandlerMixin implements UserRepository {
  final UserSource _userSource;
  final _userMapper = UserMapper();

  UserRepositoryImpl(this._userSource);

  @override
  Future<Result<List<UserEntity>>> getUsers() async {
    try {
      final userResponse = await _userSource.getUsers();

      final models = userResponse.users ?? List.empty();

      final users = models.map((model) => _userMapper.tryMap(model)).toList();

      return Result.ok(users);
    } catch (e) {
      return handleException<List<UserEntity>>(e);
    }
  }
}
