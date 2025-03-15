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
        Expanded(
          child: Column(
            children: [
              _AvailableTimeDatePicker(),
              spacer,
              const _AvailableTimePicker(),
              spacer,
              _AvailableTimeGeolocationPicker(),
            ],
          ),
        ),
        _AddAvailableTimeButton(
          onTap: () => _addAvailableTime(context),
        ),
      ],
    );
  }

  void _addAvailableTime(BuildContext context) {
    if (selectedDate == null ||
        selectedTimeFrom == null ||
        selectedTimeUntil == null ||
        selectedGeolocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Необходимо заполнить все поля'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    context.read<AvailableTimeBloc>().add(
          AvailableTimeAdd(
            AvailableTimeEntity(
              date: selectedDate!,
              timeFrom: selectedTimeFrom!,
              timeUntil: selectedTimeUntil!,
              geolocation: selectedGeolocation!,
              clubs: [],
            ),
          ),
        );
  }
}
