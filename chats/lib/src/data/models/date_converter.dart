import 'package:json_annotation/json_annotation.dart';

/// 09:27 02-03-2025
class DateJsonConverter extends JsonConverter<DateTime, String> {
  const DateJsonConverter();

  @override
  DateTime fromJson(String json) {
    final timeAndDate = json.split(' ');
    final time = timeAndDate[0];
    final date = timeAndDate[1].split('-').reversed.join('-');
    final dateTime = DateTime.parse('$date $time:00');
    return dateTime;
  }

  @override
  String toJson(DateTime object) {
    final hour = object.hour.toString().padLeft(2, '0');
    final minute = object.minute.toString().padLeft(2, '0');
    final day = object.day.toString().padLeft(2, '0');
    final month = object.month.toString().padLeft(2, '0');
    final year = object.year.toString().padLeft(4, '0');
    return '$hour:$minute $day-$month-$year';
  }
}
