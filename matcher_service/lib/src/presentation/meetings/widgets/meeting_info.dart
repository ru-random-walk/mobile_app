part of '../page.dart';

class MettingPreviewInfoWidget extends StatelessWidget {
  final MeetingPreviewInfoEntity info;

  const MettingPreviewInfoWidget({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      color: ButtonColor.black,
      isMaxWidth: false,
      size: ButtonSize.M,
      type: ButtonType.secondary,
      padding: EdgeInsets.symmetric(
        vertical: 8.toFigmaSize,
        horizontal: 22.5.toFigmaSize,
      ),
      text: _formattedTime(context),
      rightIcon: _rightIcon(),
    );
  }

  Widget _rightIcon() {
    const pathPrefix = 'packages/matcher_service/assets/icons';
    final iconName = switch (info.status) {
      MeetingStatus.inProcess => 'logo.svg',
      MeetingStatus.searching => 'search.svg',
      MeetingStatus.find => 'checked.svg',
    };
    final iconPath = '$pathPrefix/$iconName';
    return Padding(
      padding: EdgeInsets.only(left: 8.toFigmaSize),
      child: SvgPicture.asset(
        iconPath,
        // fit: BoxFit.scaleDown,
      ),
    );
  }

  String _formattedTime(BuildContext context) {
    return '${info.startTimeMeeting.format(context)}-${info.endTimeMeeting.format(context)}';
  }
}
