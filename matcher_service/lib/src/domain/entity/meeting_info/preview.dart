import 'package:flutter/material.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/status.dart';

class MeetingPreviewInfoEntity {
  final TimeOfDay startTimeMeeting;
  final TimeOfDay endTimeMeeting;
  final DateTime dateMeeting;
  final MeetingStatus status;

  MeetingPreviewInfoEntity({
    required this.startTimeMeeting,
    required this.endTimeMeeting,
    required this.dateMeeting,
    required this.status,
  });
}
