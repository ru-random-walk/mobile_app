part of '../../../../page.dart';

class _PickYearListWidget extends StatelessWidget {
  final ValueChanged<int> onYearChanged;
  final FlatSnappingListController controller;

  const _PickYearListWidget({
    required this.onYearChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    return FlatSnappingList(
      controller: controller,
      listWidth: 52.toFigmaSize,
      itemHeight: _itemExtent,
      values: List.generate(
        _yearRange,
        (index) => '${currentYear + index}',
      ),
      onIndexChanged: (index) => onYearChanged(currentYear + index),
    );
  }
}
