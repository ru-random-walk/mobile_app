part of '../../page.dart';

class _AvailableTimeBodyWidget extends StatefulWidget {
  @override
  State<_AvailableTimeBodyWidget> createState() =>
      _AvailableTimeBodyWidgetState();
}

class _AvailableTimeBodyWidgetState extends State<_AvailableTimeBodyWidget> {
  DateTime? selectedDate;

  TimeOfDay? selectedTimeFrom;

  TimeOfDay? selectedTimeUntil;

  Geolocation? selectedGeolocation;

  @override
  Widget build(BuildContext context) {
    final spacer = SizedBox(height: 20.toFigmaSize);
    return Column(
      children: [
        _AvailableTimeDatePicker(),
        spacer,
        const _AvailableTimePicker(),
        spacer,
        _AvailableTimeGeolocationPicker(),
      ],
    );
  }
}
