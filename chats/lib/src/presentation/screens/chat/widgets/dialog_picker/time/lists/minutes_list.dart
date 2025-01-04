part of '../../../../page.dart';

class _PickMinutesListWidget extends StatelessWidget {
  final ValueChanged<int> onMinutesChanged;
  final FlatSnappingListController controller;

  const _PickMinutesListWidget({
    required this.onMinutesChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FlatSnappingList(
      controller: controller,
      listWidth: 52.toFigmaSize,
      itemHeight: _itemExtent,
      values: List.generate(
        60,
        (index) => '$index'.padLeft(2, '0'),
      ),
      onIndexChanged: onMinutesChanged,
    );
  }
}
