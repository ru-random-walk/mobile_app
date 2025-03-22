import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'availabel_time.g.dart';

@JsonSerializable()
class AvailabelTimeModel {
  final String date;
  final String timeFrom;
  final String timeUntil;
  final GeolocationModel location;
  final List<String> clubsInFilter;

  AvailabelTimeModel({
    required this.date,
    required this.timeFrom,
    required this.timeUntil,
    required this.location,
    required this.clubsInFilter,
  });

  factory AvailabelTimeModel.fromJson(Map<String, dynamic> json) =>
      _$AvailabelTimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AvailabelTimeModelToJson(this);
}
