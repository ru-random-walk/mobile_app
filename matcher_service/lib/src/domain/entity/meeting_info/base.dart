import 'package:auth/auth.dart';
import 'package:clubs/clubs.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:matcher_service/src/domain/entity/available_time/modify.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/base_fields.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/status.dart';

part '../appointment/entity.dart';
part '../available_time/entity.dart';

sealed class BaseMeetingEntity implements BaseMeetingInfoEntity {
  final String id;
  final MeetingStatus status;

  BaseMeetingEntity({
    required this.id,
    required this.status,
  });
}
