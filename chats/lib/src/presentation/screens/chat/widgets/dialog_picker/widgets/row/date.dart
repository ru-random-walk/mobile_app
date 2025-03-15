part of '../../../../page.dart';

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
          final res = await showDatePickerDialog(
            context: context,
            initialDate: selectedDate,
          );
          if (res is DateTime && context.mounted) {
            updateDate(res, context);
          }
        },
      ),
    );
  }

  void updateDate(DateTime date, BuildContext context) {
    setState(() {
      selectedDate = date;
    });
    final parentState =
        context.findAncestorStateOfType<_MeetDataDialogWidgetState>();
    parentState?.selectedDate = date;
  }

  String get formattedDate {
    if (selectedDate == null) {
      return 'Не выбрано';
    }
    return DateFormat('dd.MM.yyyy').format(selectedDate!);
  }
}
