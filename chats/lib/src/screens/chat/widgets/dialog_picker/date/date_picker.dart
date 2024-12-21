part of '../../../page.dart';

final _itemExtent = 32.toFigmaSize;

const _yearRange = 20;

class _MeetDatePickerDialog extends StatefulWidget {
  @override
  State<_MeetDatePickerDialog> createState() => _MeetDatePickerDialogState();
}

class _MeetDatePickerDialogState extends State<_MeetDatePickerDialog> {
  DateTime selectedDate = DateTime.now();

  final currentAmountOfDays = ValueNotifier<int>(
    amountOfDaysForMonth(
      DateTime.now().month,
      DateTime.now().year,
    ),
  );

  bool isImplicitScrolling = false;

  late final FlatSnappingListController dayController;

  late final FlatSnappingListController monthController;

  late final FlatSnappingListController yearController;

  @override
  void initState() {
    super.initState();
    dayController = FlatSnappingListController(
      itemExtent: _itemExtent,
      initialIndex: selectedDate.day - 1,
    );

    monthController = FlatSnappingListController(
      itemExtent: _itemExtent,
      initialIndex: selectedDate.month - 1,
    );
    yearController = FlatSnappingListController(
      itemExtent: _itemExtent,
    );
  }

  static int amountOfDaysForMonth(int month, int year) {
    return DateTime(year, month + 1, 0).day;
  }

  void _onDayChanged(int day) {
    setNewDate(selectedDate.year, selectedDate.month, day);
  }

  void _onMonthChanged(int month) {
    setNewDate(selectedDate.year, month, selectedDate.day);
  }

  void _onYearChanged(int year) {
    setNewDate(year, selectedDate.month, selectedDate.day);
  }

  void setNewDate(int year, int month, int day) {
    if (selectedDate.year == year &&
        selectedDate.month == month &&
        selectedDate.day == day || isImplicitScrolling) {
      return;
    }
    final newMaxAmountOfDay = _checkAmountOfDays(month, year);
    if (day > newMaxAmountOfDay) {
      selectedDate = DateTime(
        year,
        month,
        newMaxAmountOfDay,
      );
      return;
    }
    selectedDate = DateTime(
      year,
      month,
      day,
    );
  }

  int _checkAmountOfDays(int month, int year) {
    final amount = amountOfDaysForMonth(
      month,
      year,
    );
    if (amount != currentAmountOfDays.value) {
      currentAmountOfDays.value = amount;
    }
    return amount;
  }

  void pickToday() {
    final today = DateTime.now();
    scrollToDate(today);
  }

  void pickTomorrow() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    scrollToDate(tomorrow);
  }

  void pickInAWeek() {
    final inAWeek = DateTime.now().add(const Duration(days: 7));
    scrollToDate(inAWeek);
  }

  Future<void> scrollToDate(DateTime date) async {
    isImplicitScrolling = true;
    await dayController.animateToIndex(date.day - 1);
    await monthController.animateToIndex(date.month - 1);
    await yearController.animateToIndex(date.year - DateTime.now().year);
    isImplicitScrolling = false;
    selectedDate = date;
  }

  @override
  Widget build(BuildContext context) {
    final verticalSpacer = SizedBox(height: 16.toFigmaSize);
    final spacer = SizedBox(width: 8.toFigmaSize);
    return Dialog(
      child: SizedBox(
        height: 351.toFigmaSize,
        width: 351.toFigmaSize,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.base_0,
            borderRadius: BorderRadius.circular(16.toFigmaSize),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _PickDayListWidget(
                      onDayChanged: _onDayChanged,
                      controller: dayController,
                      amountOfDays: currentAmountOfDays,
                    ),
                    spacer,
                    _PickMonthListWidget(
                      onMonthChanged: _onMonthChanged,
                      controller: monthController,
                    ),
                    spacer,
                    _PickYearListWidget(
                      onYearChanged: _onYearChanged,
                      controller: yearController,
                    ),
                  ],
                ),
                verticalSpacer,
                _SpecficDatePickButtonsGroup(
                  onTodayTap: pickToday,
                  onTomorrowTap: pickTomorrow,
                  onInAWeekTap: pickInAWeek,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
