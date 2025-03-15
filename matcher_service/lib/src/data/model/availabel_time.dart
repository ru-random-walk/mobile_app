import 'package:json_annotation/json_annotation.dart';

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
}
