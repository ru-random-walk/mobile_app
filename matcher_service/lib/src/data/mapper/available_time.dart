import 'package:matcher_service/src/data/model/availabel_time.dart';

import '../../domain/entity/available_time.dart';

extension AvailableTimeEntityMapper on AvailableTimeEntity {
  AvailabelTimeModel toModel() {
    final dateString = date.toIso8601String().substring(0, 12);
    final timeZoneOffset =
        '${date.timeZoneOffset.inHours}:${date.timeZoneOffset.inMinutes}';
    final startTime = timeFrom.hour.toString().padLeft(2, '0') +
        timeFrom.minute.toString().padLeft(2, '0') +
        timeZoneOffset;
    final endTime = timeUntil.hour.toString().padLeft(2, '0') +
        timeUntil.minute.toString().padLeft(2, '0') +
        timeZoneOffset;
    return AvailabelTimeModel(
      date: dateString,
      timeFrom: startTime,
      timeUntil: endTime,
      longitude: geolocation.longitude,
      latitude: geolocation.latitude,
      clubsInFilter: clubs.map((e) => e.id).toList(),
    );
  }
}
