part of '../date_picker.dart';

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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SpecficValuePickBaseButton(
          title: 'Сегодня',
          onTap: onTodayTap,
        ),
        spacer,
        SpecficValuePickBaseButton(
          title: 'Завтра',
          onTap: onTomorrowTap,
        ),
        spacer,
        SpecficValuePickBaseButton(
          title: 'Через неделю',
          onTap: onInAWeekTap,
        ),
      ],
    );
  }
}
