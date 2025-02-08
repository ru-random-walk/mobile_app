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
        vertical: 4.toFigmaSize,
        horizontal: 12.toFigmaSize,
      ),
      itemBuilder: (_, index) => _MeetingsForDay(
        backgroundColor: backgroundColor(
          context,
          index.isEven,
        ),
        meetings: data[index],
      ),
      separatorBuilder: (_, __) => SizedBox(
        height: 4.toFigmaSize,
      ),
      itemCount: data.length,
    );
  }

  Color backgroundColor(BuildContext context, bool isEven) {
    if (isEven) {
      return context.colors.main_20;
    } else {
      /// TODO: добаить в тему
      return const Color(0xFFBBCBFF);
    }
  }
}
