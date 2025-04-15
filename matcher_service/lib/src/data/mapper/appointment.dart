import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:matcher_service/src/data/mapper/person/status.dart';
import 'package:matcher_service/src/data/model/appointment.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/base.dart';

extension AppointmentMapper on AppointmentDetailsModel {
  AppointmentEntity toEntity(
    UserModel user,
    Geolocation geolocation,
  ) {
    final userEntity = user.toDomain();
    return AppointmentEntity(
      id: id,
      status: status.toAppointmentStatus(),
      date: startsAt,
      timeStart: TimeOfDay.fromDateTime(startsAt),
      timeEnd: TimeOfDay.fromDateTime(endedAt),
      location: geolocation,
      clubs: [],
      partner: userEntity,
    );
  }
}
