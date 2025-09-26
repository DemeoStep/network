import 'package:network/data/model/geo_model.dart';
import 'package:network/domain/entity/geo_entity.dart';

class GeoMapper {
  GeoEntity map(GeoModel from) {
    return GeoEntity(
      lat: double.tryParse(from.lat ?? '0.0') ?? 0.0,
      lng: double.tryParse(from.lng ?? '0.0') ?? 0.0,
    );
  }
}
