part of '../page.dart';

class _MettingsDayWigdet extends StatelessWidget {
  final DateTime date;

  const _MettingsDayWigdet({
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          dayOfWeek,
          style: context.textTheme.h5.copyWith(
            color: context.colors.base_80,
          ),
        ),
        SizedBox(
          height: 4.toFigmaSize,
        ),
        Text(
          '${date.day} $ofMonth',
          style: context.textTheme.h4.copyWith(
            color: context.colors.base_90,
          ),
        ),
      ],
    );
  }

  String get dayOfWeek => switch (date.weekday) {
        1 => 'Понедельник',
        2 => 'Вторник',
        3 => 'Среда',
        4 => 'Четверг',
        5 => 'Пятница',
        6 => 'Суббота',
        7 => 'Воскресенье',
        _ => 'Неизвестный день',
      };

  String get ofMonth => switch (date.month) {
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
        _ => 'Неизвестный месяц',
      };
}
