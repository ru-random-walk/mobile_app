// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clubs/clubs.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/base_fields.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/status.dart';

class MeetingPreviewInfoEntity implements BaseMeetingInfoEntity {
  final String? appointmentId;
  final String availabelTimeId;
  final MeetingStatus status;
  @override
  final DateTime date;
  @override
  final TimeOfDay timeStart;
  @override
  final TimeOfDay timeEnd;
  @override
  final Geolocation location;
  @override
  final List<ShortClubEntity> clubs;

  MeetingPreviewInfoEntity({
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    required this.location,
    required this.appointmentId,
    required this.availabelTimeId,
    required this.status,
    required this.clubs,
  });
}
