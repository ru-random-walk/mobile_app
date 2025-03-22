part of '../page.dart';

class _MeetingsBodyDataList extends StatelessWidget {
  final List<MeetingsForDayEntity> data;

  const _MeetingsBodyDataList({required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        vertical: 16.toFigmaSize,
        horizontal: 12.toFigmaSize,
      ),
      itemBuilder: (_, index) => _MeetingsForDay(
        colorMode: backgroundColor(
          context,
          index.isEven,
        ),
        meetings: data[index],
      ),
      separatorBuilder: (_, __) => SizedBox(
        height: 16.toFigmaSize,
      ),
      itemCount: data.length,
    );
  }

  MeetingColorMode backgroundColor(BuildContext context, bool isEven) {
    if (isEven) {
      return MeetingColorMode.lightGreen_7;
    } else {
      return MeetingColorMode.lightGreen_15;
    }
  }
}
