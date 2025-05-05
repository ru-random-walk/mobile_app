part of '../page.dart';

class _MeetingInfoStatusWidget extends StatelessWidget {
  final MeetingStatus status;

  const _MeetingInfoStatusWidget(this.status);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12.toFigmaSize,
        horizontal: 16.toFigmaSize,
      ),
      child: Row(
        children: [
          Text(
            _text,
            style: context.textTheme.bodyXLRegular,
          ),
          MeetingStatusIconWidget(
            status: status,
            size: 32.toFigmaSize,
            color: context.colors.main_80,
          ),
        ],
      ),
    );
  }

  String get _text => switch (status) {
        MeetingStatus.searching => 'Поиск партнера',
        MeetingStatus.requested => 'Запрошена',
        MeetingStatus.find => 'Назначена',
        MeetingStatus.inProcess => 'На прогулке',
        MeetingStatus.done => 'Завершена',
        MeetingStatus.canceled => 'Отменена',
      };
}
