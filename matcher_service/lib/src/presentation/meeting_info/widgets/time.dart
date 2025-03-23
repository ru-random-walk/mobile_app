part of '../page.dart';

class _MeetingInfoTimeWidget extends StatelessWidget {
  final BaseMeetingEntity meetingInfo;

  const _MeetingInfoTimeWidget(this.meetingInfo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.toFigmaSize),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.main_10,
            ),
            child: Padding(
              padding: EdgeInsets.all(12.toFigmaSize),
              child: SvgPicture.asset(
                'packages/chats/assets/icons/time.svg',
                colorFilter: ColorFilter.mode(
                  context.colors.main_90,
                  BlendMode.srcIn,
                ),
                width: 24.toFigmaSize,
                height: 24.toFigmaSize,
              ),
            ),
          ),
          SizedBox(
            width: 8.toFigmaSize,
          ),
          Text(
            '$_title:',
            style: context.textTheme.bodyXLMedium.copyWith(
              color: context.colors.main_90,
            ),
          ),
          SizedBox(
            width: 24.toFigmaSize,
          ),
          Text(
            _time(context),
            style: context.textTheme.bodyXLRegular,
          ),
        ],
      ),
    );
  }

  String get _title => switch (meetingInfo) {
        AppointmentEntity _ => 'Начало',
        AvailableTimeEntity _ => 'Время',
      };

  String _time(BuildContext context) => switch (meetingInfo) {
        AppointmentEntity _ => meetingInfo.timeStart.format(context),
        AvailableTimeEntity _ =>
          '${meetingInfo.timeStart.format(context)} - ${meetingInfo.timeEnd.format(context)}',
      };
}
