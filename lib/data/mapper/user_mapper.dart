import 'package:network/core/data/mapper.dart';
import 'package:network/data/mapper/address_mapper.dart';
import 'package:network/data/mapper/company_mapper.dart';
import 'package:network/data/model/address_model.dart';
import 'package:network/data/model/company_model.dart';
import 'package:network/data/model/user_model.dart';
import 'package:network/domain/entity/user_entity.dart';

class UserMapper extends Mapper<UserModel, UserEntity> {
  @override
  UserEntity tryMap(UserModel from) {
    return UserEntity(
      id: from.id ?? -1,
      name: from.name ?? '',
      username: from.username ?? '',
      email: from.email ?? '',
      address: AddressMapper().map(from.address ?? AddressModel.empty()),
      phone: from.phone ?? '',
      website: from.website ?? '',
      company: CompanyMapper().map(from.company ?? CompanyModel.empty()),
    );
  }
}
