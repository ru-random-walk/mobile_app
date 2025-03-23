part of '../../page.dart';

class MettingPreviewInfoWidget extends StatelessWidget {
  final MeetingPreviewInfoEntity info;
  final Color buttonColor;

  const MettingPreviewInfoWidget({
    super.key,
    required this.info,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      customColor: buttonColor,
      customCornerRadius: 16,
      isMaxWidth: false,
      size: ButtonSize.M,
      padding: EdgeInsets.symmetric(
        vertical: 8.toFigmaSize,
        horizontal: 22.5.toFigmaSize,
      ),
      text: _formattedTime(context),
      rightIcon: _rightIcon(),
      textStyle: context.textTheme.bodyLRegular,
    );
  }

  Widget _rightIcon() {
    const pathPrefix = 'packages/matcher_service/assets/icons';
    final iconName = switch (info.status) {
      MeetingStatus.inProcess => 'logo.svg',
      MeetingStatus.searching => 'search.svg',
      MeetingStatus.find => 'checked.svg',
      MeetingStatus.done => throw UnimplementedError(),
      MeetingStatus.canceled => throw UnimplementedError(),
      MeetingStatus.requested => throw UnimplementedError(),
    };
    final iconPath = '$pathPrefix/$iconName';
    return Padding(
      padding: EdgeInsets.only(left: 8.toFigmaSize),
      child: SvgPicture.asset(
        iconPath,
        colorFilter: const ColorFilter.mode(
          Colors.black,
          BlendMode.srcIn,
        ),
        // fit: BoxFit.scaleDown,
      ),
    );
  }

  String _formattedTime(BuildContext context) {
    return '${info.startTimeMeeting.format(context)}-${info.endTimeMeeting.format(context)}';
  }
}
