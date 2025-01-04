part of '../../../../page.dart';

class _PickHourListWidget extends StatelessWidget {
  final ValueChanged<int> onHourChanged;
  final FlatSnappingListController controller;

  const _PickHourListWidget({
    required this.onHourChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FlatSnappingList(
      controller: controller,
      listWidth: 52.toFigmaSize,
      itemHeight: _itemExtent,
      values: List.generate(
        25,
        (index) => '$index'.padLeft(2, '0'),
      ),
      onIndexChanged: onHourChanged,
    );
  }
}
