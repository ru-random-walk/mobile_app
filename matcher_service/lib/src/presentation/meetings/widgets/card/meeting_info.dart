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
      rightIcon: _rightIcon(context),
      textStyle: context.textTheme.bodyLRegular,
      onPressed: () {
        final args = info.appointmentId != null
            ? AppointmentIdArgs(info.appointmentId!)
            : AvailableTimeInfoArgs(AvailableTimeEntity(
                id: info.availabelTimeId ?? 'invalid',
                status: info.status,
                date: info.date,
                timeStart: info.timeStart,
                timeEnd: info.timeEnd,
                location: info.location,
                clubs: info.clubs,
              ));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => Provider.value(
              value: context.read<PersonRepositoryI>(),
              child: MeetingInfoPage(args: args),
            ),
          ),
        );
      },
    );
  }

  Widget _rightIcon(BuildContext context) {
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
        colorFilter: ColorFilter.mode(
          context.colors.base_80,
          BlendMode.srcIn,
        ),
        // fit: BoxFit.scaleDown,
      ),
    );
  }

  String _formattedTime(BuildContext context) {
    return '${info.timeStart.format(context)}-${info.timeEnd.format(context)}';
  }
}
