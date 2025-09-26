import 'package:json_annotation/json_annotation.dart';
import 'package:network/core/exceptions/json_parse_exception.dart';
import 'package:network/data/model/address_model.dart';
import 'package:network/data/model/company_model.dart';

part 'user_model.g.dart';

class UserModelList {
  final List<UserModel>? users;

  UserModelList({this.users});

  factory UserModelList.fromJson(List<dynamic> json) {
    try {
      return UserModelList(
        users: json.map((user) => UserModel.tryParse(user)).toList(),
      );
    } catch (e) {
      throw JsonParseException('Failed to parse UserModelList: $e', json);
    }
  }
}

@JsonSerializable()
class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final AddressModel address;
  final String phone;
  final String website;
  final CompanyModel company;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory UserModel.tryParse(Map<String, dynamic> json) {
    try {
      return UserModel._fromJson(json);
    } catch (e) {
      throw JsonParseException('Failed to parse UserModel: $e', json);
    }
  }

  factory UserModel._fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
