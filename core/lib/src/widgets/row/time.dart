part of 'widgets.dart';

class PickMeetTimeButton extends StatefulWidget {
  final ButtonSize size;
  final double? width;
  final void Function(TimeOfDay time) onTimeUpdated;

  const PickMeetTimeButton({
    super.key,
    required this.onTimeUpdated,
    required this.size,
    this.width,
  });

  @override
  State<PickMeetTimeButton> createState() => _PickMeetTimeButtonState();
}

class _PickMeetTimeButtonState extends State<PickMeetTimeButton> {
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return _MeetDataPickButton(
      width: widget.width,
      size: widget.size,
      title: selectedTimeString,
      icon: SvgPicture.asset(
        'packages/chats/assets/icons/time.svg',
      ),
      onTap: () async {
        final res = await showTimePickerDialog(
          context: context,
          initialTime: selectedTime,
        );
        if (res is TimeOfDay && context.mounted) {
          updateTime(res, context);
        }
      },
    );
  }

  void updateTime(TimeOfDay time, BuildContext context) {
    setState(() {
      selectedTime = time;
      widget.onTimeUpdated(time);
    });
  }


  String get selectedTimeString {
    if (selectedTime == null) {
      return 'Не выбрано';
    }
    return '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}';
  }
}
