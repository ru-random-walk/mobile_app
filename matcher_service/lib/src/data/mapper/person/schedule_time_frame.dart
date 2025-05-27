import 'package:clubs/clubs.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:matcher_service/src/data/mapper/person/status.dart';
import 'package:matcher_service/src/data/model/schedule/schedule_time_frame.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/preview.dart';

extension ScheduleTimeFrameMapper on ScheduleTimeFrameModel {
  MeetingPreviewInfoEntity toEntity(
    DateTime date,
    List<ShortClubEntity> clubs,
  ) {
    final startTimeMeeting = TimeOfDay(
      hour: timeFrom.hour,
      minute: timeFrom.minute,
    );
    final endTimeMeeting = TimeOfDay(
      hour: timeUntil.hour,
      minute: timeUntil.minute,
    );
    return MeetingPreviewInfoEntity(
      timeStart: startTimeMeeting,
      timeEnd: endTimeMeeting,
      status: appointmentStatus.toAppointmentStatus(),
      appointmentId: appointmentId,
      availabelTimeId: availableTimeId,
      date: date,
      location: location.toDomain(),
      clubs: clubs,
    );
  }
}
