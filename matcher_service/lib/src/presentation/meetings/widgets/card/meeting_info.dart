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
      rightIcon: MeetingStatusIconWidget(
        status: info.status,
        size: 24.toFigmaSize,
        color: context.colors.base_80,
      ),
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

  String _formattedTime(BuildContext context) {
    return '${info.timeStart.format(context)}-${info.timeEnd.format(context)}';
  }
}
