import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable()
class AppointmentDetailsModel {
  final String id;
  final List<String> participants;
  final DateTime startsAt;
  final DateTime updatedAt;
  final DateTime endedAt;
  final String status;
  final double longitude;
  final double latitude;

  AppointmentDetailsModel({
    required this.id,
    required this.participants,
    required this.startsAt,
    required this.updatedAt,
    required this.endedAt,
    required this.status,
    required this.longitude,
    required this.latitude,
  });

  factory AppointmentDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentDetailsModelFromJson(json);
}
