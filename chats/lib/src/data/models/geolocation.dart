import 'package:json_annotation/json_annotation.dart';

part 'geolocation.g.dart';

@JsonSerializable()
class GeolocationModel {
  final double latitude;
  final double longitude;
  final String city;
  final String street;
  final String? building;

  GeolocationModel({
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.street,
    this.building,
  });

  factory GeolocationModel.fromJson(Map<String, dynamic> json) =>
      _$GeolocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeolocationModelToJson(this);
}
