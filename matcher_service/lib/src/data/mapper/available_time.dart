import 'package:core/core.dart';

import '../../domain/entity/available_time/modify.dart';
import '../model/availabel_time.dart';

extension AvailableTimeEntityMapper on AvailableTimeModifyEntity {
  AvailabelTimeModel toModel() {
    final dateString = date.toIso8601String().substring(0, 10);
    final timeZoneOffset =
        '${date.timeZoneOffset.inHours.toString().padLeft(2, '0')}:${(date.timeZoneOffset.inMinutes % 60).toString().padLeft(2, '0')}';
    final startTime =
        '${timeStart.hour.toString().padLeft(2, '0')}:${timeStart.minute.toString().padLeft(2, '0')}+$timeZoneOffset';
    final endTime =
        '${timeEnd.hour.toString().padLeft(2, '0')}:${timeEnd.minute.toString().padLeft(2, '0')}+$timeZoneOffset';
    return AvailabelTimeModel(
      date: dateString,
      timeFrom: startTime,
      timeUntil: endTime,
      location: location.toModel(),
      clubsInFilter: clubs.map((e) => e.id).toList(),
    );
  }
}
