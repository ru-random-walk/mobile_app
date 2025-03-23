import 'package:flutter/material.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/status.dart';

class MeetingPreviewInfoEntity {
  final DateTime date;
  final TimeOfDay startTimeMeeting;
  final TimeOfDay endTimeMeeting;
  final String? appointmentId;
  final String availabelTimeId;
  final MeetingStatus status;

  MeetingPreviewInfoEntity({
    required this.date,
    required this.startTimeMeeting,
    required this.endTimeMeeting,
    required this.status,
    required this.appointmentId,
    required this.availabelTimeId,
  });
}
