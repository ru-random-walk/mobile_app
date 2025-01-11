part of '../../../../../page.dart';

class _PickMeetDateRow extends StatefulWidget {
  @override
  State<_PickMeetDateRow> createState() => _PickMeetDateRowState();
}

class _PickMeetDateRowState extends State<_PickMeetDateRow> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return _MeetDataRowWidget(
      title: 'Дата',
      button: _MeetDataPickButton(
        title: formattedDate,
        icon: SvgPicture.asset(
          'packages/chats/assets/icons/calendar.svg',
        ),
        onTap: () async {
          final res = await showDialog(
            context: context,
            builder: (context) {
              return _MeetDatePickerDialog(
                initialDate: selectedDate,
              );
            },
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

  String get formattedDate {
    if (selectedDate == null) {
      return 'Не выбрано';
    }
    return DateFormat('dd.MM.yyyy').format(selectedDate!);
  }
}
