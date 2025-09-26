import 'package:json_annotation/json_annotation.dart';

part 'geo_model.g.dart';

@JsonSerializable()
class GeoModel {
  final String? lat;
  final String? lng;

  GeoModel({required this.lat, required this.lng});

  factory GeoModel.empty() => GeoModel(lat: '', lng: '');

  factory GeoModel.fromJson(Map<String, dynamic> json) =>
      _$GeoModelFromJson(json);
}
