import 'package:clubs/clubs.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

abstract interface class BaseMeetingInfoEntity {
  DateTime get date;
  TimeOfDay get timeStart;
  TimeOfDay? get timeEnd;
  Geolocation get location;
  List<ShortClubEntity> get clubs;
}
