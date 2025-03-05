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
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
