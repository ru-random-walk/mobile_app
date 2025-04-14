import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_time_frame.g.dart';

@JsonSerializable(converters: [
  _TimeJsonConverter(),
])
class ScheduleTimeFrameModel {
  final String? partnerId;
  final String? appointmentId;
  final String? availableTimeId;
  final TimeOfDay timeFrom;
  final TimeOfDay timeUntil;
  final GeolocationModel location;
  final List<String>? availableTimeClubsInFilter;
  final String? appointmentStatus;

  ScheduleTimeFrameModel({
    required this.partnerId,
    required this.appointmentId,
    required this.availableTimeId,
    required this.timeFrom,
    required this.timeUntil,
    required this.location,
    required this.availableTimeClubsInFilter,
    required this.appointmentStatus,
  });

  factory ScheduleTimeFrameModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleTimeFrameModelFromJson(json);
}

class _TimeJsonConverter extends JsonConverter<TimeOfDay, String> {
  const _TimeJsonConverter();

  @override
  TimeOfDay fromJson(String json) {
    final hours = json.split(':')[0];
    final minutes = json.split(':')[1].substring(0, 2);
    return TimeOfDay(
      hour: int.parse(hours),
      minute: int.parse(minutes),
    );
  }

  @override
  String toJson(TimeOfDay object) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
