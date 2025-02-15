part of '../page.dart';

final data = [
  MeetingsForDayEntity(
    date: DateTime.timestamp(),
    meetings: [
      MeetingPreviewInfoEntity(
        startTimeMeeting: TimeOfDay.now(),
        endTimeMeeting: TimeOfDay.now().replacing(minute: 59),
        dateMeeting: DateTime.now(),
        status: MeetingStatus.find,
      ),
    ],
  ),
  MeetingsForDayEntity(
    date: DateTime.timestamp(),
    meetings: [
      MeetingPreviewInfoEntity(
        startTimeMeeting: TimeOfDay.now(),
        endTimeMeeting: TimeOfDay.now().replacing(minute: 59),
        dateMeeting: DateTime.now(),
        status: MeetingStatus.searching,
      ),
      MeetingPreviewInfoEntity(
        startTimeMeeting: TimeOfDay.now(),
        endTimeMeeting: TimeOfDay.now().replacing(minute: 59),
        dateMeeting: DateTime.now(),
        status: MeetingStatus.inProcess,
      ),
      MeetingPreviewInfoEntity(
        startTimeMeeting: TimeOfDay.now(),
        endTimeMeeting: TimeOfDay.now().replacing(minute: 59),
        dateMeeting: DateTime.now(),
        status: MeetingStatus.find,
      ),
    ],
  ),
  MeetingsForDayEntity(
    date: DateTime.timestamp(),
    meetings: [
      MeetingPreviewInfoEntity(
        startTimeMeeting: TimeOfDay.now(),
        endTimeMeeting: TimeOfDay.now().replacing(minute: 59),
        dateMeeting: DateTime.now(),
        status: MeetingStatus.inProcess,
      ),
    ],
  ),
];

class _MeetingsBodyDataList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        vertical: 16.toFigmaSize,
        horizontal: 12.toFigmaSize,
      ),
      itemBuilder: (_, index) => _MeetingsForDay(
        colorMode: backgroundColor(
          context,
          index.isEven,
        ),
        meetings: data[index],
      ),
      separatorBuilder: (_, __) => SizedBox(
        height: 16.toFigmaSize,
      ),
      itemCount: data.length,
    );
  }

  MeetingColorMode backgroundColor(BuildContext context, bool isEven) {
    if (isEven) {
      return MeetingColorMode.lightGreen_7;
    } else {
      return MeetingColorMode.lightGreen_15;
    }
  }
}
