import 'package:network/data/model/user_model.dart';

abstract interface class UserSource {
  Future<UserModelList> getUsers();
}
