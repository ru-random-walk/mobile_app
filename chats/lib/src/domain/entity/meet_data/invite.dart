import 'package:core/core.dart';
import 'package:flutter/material.dart';

class InviteEntity {
  final DateTime date;
  final TimeOfDay time;
  final Geolocation place;

  InviteEntity({
    required this.date,
    required this.time,
    required this.place,
  });
}
