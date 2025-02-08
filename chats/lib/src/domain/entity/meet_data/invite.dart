import 'package:chats/src/domain/entity/meet_data/geolocation.dart';
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
