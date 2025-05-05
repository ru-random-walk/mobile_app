part of '../page.dart';

class _MeetingInfoPlaceWidget extends StatelessWidget {
  final BaseMeetingEntity meetingInfo;

  const _MeetingInfoPlaceWidget(this.meetingInfo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.toFigmaSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.main_10,
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.toFigmaSize),
                  child: SvgPicture.asset(
                    'packages/chats/assets/icons/place.svg',
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
            ],
          ),
          Visibility(
            visible: meetingInfo.location.hasDisplayName,
            child: Padding(
              padding: EdgeInsets.only(
                top: 16.toFigmaSize,
                left: 4.toFigmaSize,
              ),
              child: Text(
                meetingInfo.location.toString(),
                style: context.textTheme.bodyXLRegular.copyWith(
                  color: context.colors.base_80,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16.toFigmaSize,
          ),
          SizedBox(
            height: 140.toFigmaSize,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                    color: context.colors.main_50,
                    strokeAlign: BorderSide.strokeAlignOutside),
                borderRadius: BorderRadius.circular(16.toFigmaSize),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.toFigmaSize),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            _MapPreview(geolocation: meetingInfo.location),
                      ),
                    );
                  },
                  child: IgnorePointer(
                    child: MapViewer(
                      geolocation: meetingInfo.location,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String get _title => switch (meetingInfo) {
        AppointmentEntity _ => 'Место встречи',
        AvailableTimeEntity _ => 'Исходный адрес',
      };
}
