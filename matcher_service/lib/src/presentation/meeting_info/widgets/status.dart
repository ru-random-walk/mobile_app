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
          _icon(context),
        ],
      ),
    );
  }

  Widget _icon(BuildContext context) {
    const pathPrefix = 'packages/matcher_service/assets/icons';
    /// 
    switch (status) {
      case MeetingStatus.inProcess:
      case MeetingStatus.searching:
      case MeetingStatus.find:
        break;
      case MeetingStatus.done:
      case MeetingStatus.canceled:
      case MeetingStatus.requested:
        return const Icon(Icons.ac_unit_sharp);
    }
    ///
    final iconName = switch (status) {
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
          context.colors.main_80,
          BlendMode.srcIn,
        ),
        width: 32.toFigmaSize,
        height: 32.toFigmaSize,
        // fit: BoxFit.scaleDown,
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
