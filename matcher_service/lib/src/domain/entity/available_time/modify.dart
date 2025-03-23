import 'package:clubs/clubs.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/base_fields.dart';

class AvailableTimeModifyEntity implements BaseMeetingInfoEntity {
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

  AvailableTimeModifyEntity({
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    required this.location,
    required this.clubs,
  });

  @protected
  AvailableTimeModifyEntity copyWith({
    DateTime? date,
    TimeOfDay? timeStart,
    TimeOfDay? timeEnd,
    Geolocation? location,
    List<ShortClubEntity>? clubs,
  }) {
    return AvailableTimeModifyEntity(
      date: date ?? this.date,
      timeStart: timeStart ?? this.timeStart,
      timeEnd: timeEnd ?? this.timeEnd,
      location: location ?? this.location,
      clubs: clubs ?? this.clubs,
    );
  }
}
