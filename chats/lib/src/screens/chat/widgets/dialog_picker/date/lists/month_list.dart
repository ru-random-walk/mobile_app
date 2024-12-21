part of '../../../../page.dart';

class _PickMonthListWidget extends StatelessWidget {
  final ValueChanged<int> onMonthChanged;
  final FlatSnappingListController controller;

  const _PickMonthListWidget({
    required this.onMonthChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FlatSnappingList(
      controller: controller,
      listWidth: 80.toFigmaSize,
      itemHeight: _itemExtent,
      values: _months,
      onIndexChanged: (index) => onMonthChanged(index + 1),
    );
  }
}

const _months = [
  'январь',
  'февраль',
  'март',
  'апрель',
  'май',
  'июнь',
  'июль',
  'август',
  'сентябрь',
  'октябрь',
  'ноябрь',
  'декабрь',
];
