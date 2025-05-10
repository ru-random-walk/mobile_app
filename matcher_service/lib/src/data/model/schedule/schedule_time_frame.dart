import 'dart:developer';

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
    try {
      final now = DateTime.now();
      final dateStr =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}T$json";
      final dateTime = DateTime.parse(dateStr);
      // Convert to local time
      final localTime = dateTime.toLocal();
      final res = TimeOfDay.fromDateTime(localTime);
      return res;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  String toJson(TimeOfDay object) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
