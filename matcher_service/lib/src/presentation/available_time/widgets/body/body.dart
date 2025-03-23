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
    return BlocListener<AvailableTimeBloc, AvailableTimeState>(
      listener: (context, state) {
        switch (state) {
          case AvailableTimeCreatingLoading():
          case AvailableTimeCreatingSuccess():
            Navigator.of(context).pop(true);
          case AvailableTimeCreatingError():
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Что-то пошло не так',
                ),
              ),
            );
          case Idle():
        }
      },
      child: Column(
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
      ),
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
            AvailableTimeModifyEntity(
              date: selectedDate!,
              timeStart: selectedTimeFrom!,
              timeEnd: selectedTimeUntil!,
              location: selectedGeolocation!,
              clubs: [],
            ),
          ),
        );
  }
}
