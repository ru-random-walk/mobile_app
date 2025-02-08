part of '../page.dart';

class _MeetingsForDay extends StatelessWidget {
  final MeetingsForDayEntity meetings;
  final Color backgroundColor;

  const _MeetingsForDay({
    required this.meetings,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.toFigmaSize),
        color: backgroundColor,
      ),
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
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
