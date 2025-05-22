import 'package:json_annotation/json_annotation.dart';

part 'query.g.dart';

@JsonSerializable(createFactory: false)
class GeocoderQueryModel {
  @JsonKey(name: 'lat')
  final double latitude;

  @JsonKey(name: 'lon')
  final double longitude;

  final count = 1;

  GeocoderQueryModel({
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() => _$GeocoderQueryModelToJson(this);
}
