part of '../../../../page.dart';

class _MeetDataPickersGroupWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final verticalSpacer = SizedBox(height: 4.toFigmaSize);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.toFigmaSize,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          verticalSpacer,
          _PickMeetDateRow(),
          verticalSpacer,
          _PickMeetTimeRow(),
          verticalSpacer,
          _PickMeetPlaceRow(),
        ],
      ),
    );
  }
}
