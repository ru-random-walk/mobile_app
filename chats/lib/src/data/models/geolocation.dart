import 'package:json_annotation/json_annotation.dart';

part 'geolocation.g.dart';

@JsonSerializable()
class GeolocationModel {
  final double latitude;
  final double longitude;

  GeolocationModel({
    required this.latitude,
    required this.longitude,
  });

  factory GeolocationModel.fromJson(Map<String, dynamic> json) =>
      _$GeolocationModelFromJson(json);
}
