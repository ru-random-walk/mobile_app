part of 'widgets.dart';

class PickMeetDateButton extends StatefulWidget {
  final ButtonSize size;
  final double? width;
  final void Function(DateTime date) onDateUpdated;
  final DateTime? initialValue;

  const PickMeetDateButton({
    super.key,
    required this.onDateUpdated,
    required this.size,
    this.width,
    this.initialValue,
  });

  @override
  State<PickMeetDateButton> createState() => _PickMeetDateButtonState();
}

class _PickMeetDateButtonState extends State<PickMeetDateButton> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return _MeetDataPickButton(
      width: widget.width,
      size: widget.size,
      title: formattedDate,
      icon: SvgPicture.asset(
        'packages/chats/assets/icons/calendar.svg',
      ),
      onTap: () async {
        final res = await showDatePickerDialog(
          context: context,
          initialDate: selectedDate,
        );
        if (res is DateTime && context.mounted) {
          updateDate(res, context);
        }
      },
    );
  }

  void updateDate(DateTime date, BuildContext context) {
    setState(() {
      selectedDate = date;
      widget.onDateUpdated(date);
    });
  }

  String get formattedDate {
    if (selectedDate == null) {
      return 'Не выбрано';
    }
    return '${selectedDate!.day.toString().padLeft(2, '0')}.${selectedDate!.month.toString().padLeft(2, '0')}.${selectedDate!.year}';
  }
}
