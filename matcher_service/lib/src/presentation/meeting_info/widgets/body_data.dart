part of '../page.dart';

class _MeetingInfoBodyData extends StatelessWidget {
  final BaseMeetingEntity meetingEntity;

  const _MeetingInfoBodyData(this.meetingEntity);

  @override
  Widget build(BuildContext context) {
    final divider = SizedBox(height: 24.toFigmaSize);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.toFigmaSize,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MeetingInfoDateWidget(meetingEntity.date),
            divider,
            _MeetingInfoStatusWidget(meetingEntity.status),
            divider,
            _MeetingInfoTimeWidget(meetingEntity),
            divider,
            _MeetingInfoPlaceWidget(meetingEntity),
          ],
        ),
      ),
    );
  }
}
