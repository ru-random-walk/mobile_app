extension DateTimeExtension on DateTime {
  String toIso8601StringWithTz() {
    // Get offset
    final timeZoneOffset = this.timeZoneOffset;
    final sign = timeZoneOffset.isNegative ? '-' : '+';
    final hours = timeZoneOffset.inHours.abs().toString().padLeft(2, '0');
    final minutes =
        timeZoneOffset.inMinutes.abs().remainder(60).toString().padLeft(2, '0');
    final offsetString = '$sign$hours$minutes';

    // Get first part of properly formatted ISO 8601 date
    final formattedDate = '${toIso8601String().split('.').first}.000';

    return '$formattedDate$offsetString';
  }
}

