part of '../page.dart';

class _MeetingInfoDateWidget extends StatelessWidget {
  final DateTime date;

  const _MeetingInfoDateWidget(this.date);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.main_20,
        borderRadius: BorderRadius.circular(6.toFigmaSize),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.toFigmaSize),
        child: Center(
          child: Text(
            _formattedDate,
            style: context.textTheme.h4.copyWith(
              color: context.colors.base_80,
            ),
          ),
        ),
      ),
    );
  }

  String get _formattedDate {
    final day = date.weekday;
    final dayOfWeek = _dayOfWeek(day);
    final dayOfMonth = date.day.toString().padLeft(2, '0');
    final month = _month(date.month);
    final year = date.year.toString();
    return '$dayOfWeek, $dayOfMonth $month $year';
  }

  String _dayOfWeek(int day) => switch (day) {
        1 => 'Понедельник',
        2 => 'Вторник',
        3 => 'Среда',
        4 => 'Четверг',
        5 => 'Пятница',
        6 => 'Суббота',
        7 => 'Воскресенье',
        _ => 'Ошибка',
      };

  String _month(int month) => switch (month) {
        1 => 'января',
        2 => 'февраля',
        3 => 'марта',
        4 => 'апреля',
        5 => 'мая',
        6 => 'июня',
        7 => 'июля',
        8 => 'августа',
        9 => 'сентября',
        10 => 'октября',
        11 => 'ноября',
        12 => 'декабря',
        _ => 'Ошибка',
      };
}
