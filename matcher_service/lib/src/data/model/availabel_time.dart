import 'package:json_annotation/json_annotation.dart';

part 'availabel_time.g.dart';

@JsonSerializable()
class AvailabelTimeModel {
  final String date;
  final String timeFrom;
  final String timeUntil;
  final double longitude;
  final double latitude;
  final List<String> clubsInFilter;

  AvailabelTimeModel({
    required this.date,
    required this.timeFrom,
    required this.timeUntil,
    required this.longitude,
    required this.latitude,
    required this.clubsInFilter,
  });

  factory AvailabelTimeModel.fromJson(Map<String, dynamic> json) =>
      _$AvailabelTimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AvailabelTimeModelToJson(this);
}
