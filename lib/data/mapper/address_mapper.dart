import 'package:network/data/mapper/geo_mapper.dart';
import 'package:network/data/model/address_model.dart';
import 'package:network/data/model/geo_model.dart';
import 'package:network/domain/entity/address_entity.dart';

class AddressMapper {
  AddressEntity map(AddressModel from) {
    return AddressEntity(
      street: from.street ?? '',
      suite: from.suite ?? '',
      city: from.city ?? '',
      zipcode: from.zipcode ?? '',
      geo: GeoMapper().map(from.geo ?? GeoModel.empty()),
    );
  }
}
