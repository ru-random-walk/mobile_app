part of '../../../../../page.dart';

class _PickMeetTimeRow extends StatefulWidget {
  @override
  State<_PickMeetTimeRow> createState() => _PickMeetTimeRowState();
}

class _PickMeetTimeRowState extends State<_PickMeetTimeRow> {
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return _MeetDataRowWidget(
      title: 'Время',
      button: _MeetDataPickButton(
        title: selectedTimeString,
        icon: SvgPicture.asset(
          'packages/chats/assets/icons/time.svg',
        ),
        onTap: () async {
          final res = await showDialog(
            context: context,
            builder: (_) => _MeetTimePickerDialog(initialTime: selectedTime,),
          );
          if (res != null) {
            setState(() {
              selectedTime = res;
            });
          }
        },
      ),
    );
  }

  String get selectedTimeString {
    if (selectedTime == null) {
      return 'Не выбрано';
    }
    return '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}';
  }
}
