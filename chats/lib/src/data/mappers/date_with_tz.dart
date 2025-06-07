import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

class DateWithTimeZoneConverter extends JsonConverter<DateTime, String> {
  const DateWithTimeZoneConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json).toLocal();
  }

  @override
  String toJson(DateTime object) => object.toIso8601StringWithTz();
}
