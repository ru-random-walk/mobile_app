import 'package:clubs/clubs.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AvailableTimeEntity {
  final DateTime date;
  final TimeOfDay timeFrom;
  final TimeOfDay timeUntil;
  final Geolocation geolocation;
  final List<ShortClubEntity> clubs;

  AvailableTimeEntity({
    required this.date,
    required this.timeFrom,
    required this.timeUntil,
    required this.geolocation,
    required this.clubs,
  });
}
