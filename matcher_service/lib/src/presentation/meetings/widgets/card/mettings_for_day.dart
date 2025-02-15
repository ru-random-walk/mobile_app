part of '../../page.dart';

class _MeetingsForDay extends StatelessWidget {
  final MeetingsForDayEntity meetings;
  final MeetingColorMode colorMode;

  const _MeetingsForDay({
    required this.meetings,
    required this.colorMode,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.toFigmaSize),
          color: _getBackgroundColor(context),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8.toFigmaSize,
              offset: const Offset(0, 2)
            ),
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20.toFigmaSize,
          horizontal: 16.toFigmaSize,
        ),
        child: Row(
          children: [
            _MettingsDayWigdet(
              date: meetings.date,
            ),
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final meeting in meetings.meetings)
                  Padding(
                    padding: EdgeInsets.all(4.toFigmaSize),
                    child: MettingPreviewInfoWidget(
                      info: meeting,
                      buttonColor: _getButtonColor(context),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) => switch (colorMode) {
        MeetingColorMode.lightGreen_7 => context.colors.main_7,
        MeetingColorMode.lightGreen_15 => context.colors.main_15,
      };

  Color _getButtonColor(BuildContext context) => switch (colorMode) {
        MeetingColorMode.lightGreen_7 => context.colors.main_20,
        MeetingColorMode.lightGreen_15 => context.colors.main_30,
      };
}
