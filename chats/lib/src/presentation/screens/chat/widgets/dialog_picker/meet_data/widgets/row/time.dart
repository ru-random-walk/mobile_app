part of '../../../../../page.dart';

class _PickMeetTimeRow extends StatefulWidget {
  @override
  State<_PickMeetTimeRow> createState() => _PickMeetTimeRowState();
}

class _PickMeetTimeRowState extends State<_PickMeetTimeRow> {
  TimeOfDay? selectedDate;

  @override
  Widget build(BuildContext context) {
    return _MeetDataRowWidget(
      title: 'Время',
      button: _MeetDataPickButton(
        title: selectedTime,
        icon: SvgPicture.asset(
          'packages/chats/assets/icons/time.svg',
        ),
        onTap: () async {
          final res = await showDialog(
            context: context,
            builder: (_) => _MeetTimePickerDialog(),
          );
          if (res != null) {
            setState(() {
              selectedDate = res;
            });
          }
        },
      ),
    );
  }

  String get selectedTime {
    if (selectedDate == null) {
      return 'Не выбрано';
    }
    return '${selectedDate!.hour.toString().padLeft(2, '0')}:${selectedDate!.minute.toString().padLeft(2, '0')}';
  }
}
