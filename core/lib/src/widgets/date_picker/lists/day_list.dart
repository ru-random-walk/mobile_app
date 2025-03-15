part of '../date_picker.dart';

class _PickDayListWidget extends StatefulWidget {
  final ValueChanged<int> onDayChanged;
  final FlatSnappingListController controller;
  final ValueNotifier<int> amountOfDays;

  const _PickDayListWidget({
    required this.onDayChanged,
    required this.controller,
    required this.amountOfDays,
  });

  @override
  State<_PickDayListWidget> createState() => _PickDayListWidgetState();
}

class _PickDayListWidgetState extends State<_PickDayListWidget> {
  late int amountOfDay;
  int selectedDay = DateTime.now().day;

  @override
  void initState() {
    super.initState();
    amountOfDay = widget.amountOfDays.value;
    widget.amountOfDays.addListener(() {
      final newMaxAmountOfDay = widget.amountOfDays.value;
      // if (newMaxAmountOfDay < selectedDay) {
      //   widget.onDayChanged(newMaxAmountOfDay);
      // }
      amountOfDay = newMaxAmountOfDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.amountOfDays,
      builder: (context, value, child) {
        return FlatSnappingList(
          controller: widget.controller,
          listWidth: 36.toFigmaSize,
          itemHeight: itemExtent,
          values: List.generate(
            value,
            (index) => '${index + 1}',
          ),
          onIndexChanged: (index) {
            final newDay = index + 1;
            selectedDay = newDay;
            widget.onDayChanged(newDay);
          },
        );
      },
    );
  }
}
