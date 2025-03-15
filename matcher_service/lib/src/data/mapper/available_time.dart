import '../../domain/entity/available_time.dart';
import '../model/availabel_time.dart';

extension AvailableTimeEntityMapper on AvailableTimeEntity {
  AvailabelTimeModel toModel() {
    final dateString = date.toIso8601String().substring(0, 10);
    final timeZoneOffset =
        '${date.timeZoneOffset.inHours.toString().padLeft(2, '0')}:${(date.timeZoneOffset.inMinutes % 60).toString().padLeft(2, '0')}';
    final startTime =
        '${timeFrom.hour.toString().padLeft(2, '0')}:${timeFrom.minute.toString().padLeft(2, '0')}+$timeZoneOffset';
    final endTime =
        '${timeUntil.hour.toString().padLeft(2, '0')}:${timeUntil.minute.toString().padLeft(2, '0')}+$timeZoneOffset';
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
