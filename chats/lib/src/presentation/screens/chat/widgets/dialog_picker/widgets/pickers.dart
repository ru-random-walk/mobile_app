part of '../../../page.dart';

class _MeetDataPickersGroupWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final parentState =
        context.findAncestorStateOfType<_MeetDataDialogWidgetState>();
    final verticalSpacer = SizedBox(height: 4.toFigmaSize);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.toFigmaSize,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          verticalSpacer,
          _MeetDataRowWidget(
            title: 'Дата',
            button: PickMeetDateButton(
              width: 210.toFigmaSize,
              size: ButtonSize.S,
              onDateUpdated: (date) => parentState?.selectedDate = date,
            ),
          ),
          verticalSpacer,
          _MeetDataRowWidget(
            title: 'Время',
            button: PickMeetTimeButton(
              width: 210.toFigmaSize,
              size: ButtonSize.S,
              onTimeUpdated: (time) => parentState?.selectedTime = time,
            ),
          ),
          verticalSpacer,
          _MeetDataRowWidget(
            title: 'Место',
            button: PickMeetPlaceButton(
              width: 210.toFigmaSize,
              size: ButtonSize.S,
              onGeolocationUpdated: (geolocation) =>
                  parentState?.geolocation = geolocation,
            ),
          ),
        ],
      ),
    );
  }
}
