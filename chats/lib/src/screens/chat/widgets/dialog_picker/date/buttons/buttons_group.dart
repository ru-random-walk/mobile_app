part of '../../../../page.dart';

class _SpecficDatePickButtonsGroup extends StatelessWidget {
  final VoidCallback? onTodayTap;
  final VoidCallback? onTomorrowTap;
  final VoidCallback? onInAWeekTap;

  const _SpecficDatePickButtonsGroup({
    this.onTodayTap,
    this.onTomorrowTap,
    this.onInAWeekTap,
  });

  @override
  Widget build(BuildContext context) {
    final spacer = SizedBox(width: 8.toFigmaSize);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.toFigmaSize,
        vertical: 8.toFigmaSize,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SpecficDatePickBaseButton(
            title: 'Сегодня',
            onTap: onTodayTap,
            padding: EdgeInsets.all(8.toFigmaSize),
          ),
          spacer,
          _SpecficDatePickBaseButton(
            title: 'Завтра',
            onTap: onTomorrowTap,
            padding: EdgeInsets.all(8.toFigmaSize),
          ),
          spacer,
          _SpecficDatePickBaseButton(
            title: 'Через неделю',
            onTap: onInAWeekTap,
            padding: EdgeInsets.all(8.toFigmaSize),
          ),
        ],
      ),
    );
  }
}
