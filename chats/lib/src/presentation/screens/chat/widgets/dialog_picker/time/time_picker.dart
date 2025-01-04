part of '../../../page.dart';

class _MeetTimePickerDialog extends StatefulWidget {
  @override
  State<_MeetTimePickerDialog> createState() => _MeetTimePickerDialogState();
}

class _MeetTimePickerDialogState extends State<_MeetTimePickerDialog> {
  var selectedTime = TimeOfDay.now();

  bool isImplicitScrolling = false;

  late final FlatSnappingListController hoursController;

  late final FlatSnappingListController minutesController;

  @override
  void initState() {
    super.initState();
    hoursController = FlatSnappingListController(
      itemExtent: _itemExtent,
      initialIndex: selectedTime.hour,
    );

    minutesController = FlatSnappingListController(
      itemExtent: _itemExtent,
      initialIndex: selectedTime.minute,
    );
  }

  void updateSelectedTime({int? hour, int? minute}) {
    if (hour != null) {
      selectedTime = TimeOfDay(hour: hour, minute: selectedTime.minute);
    }
    if (minute != null) {
      selectedTime = TimeOfDay(hour: selectedTime.hour, minute: minute);
    }
  }

  void pick9Hour() {
    const _9_00 = TimeOfDay(hour: 9, minute: 0);
    scrollToTime(_9_00);
  }

  void pick12Hour() {
    const _12_00 = TimeOfDay(hour: 12, minute: 0);
    scrollToTime(_12_00);
  }

  void pick15Hour() {
    const _15_00 = TimeOfDay(hour: 15, minute: 0);
    scrollToTime(_15_00);
  }

  void pick18Hour() {
    const _18_00 = TimeOfDay(hour: 18, minute: 0);
    scrollToTime(_18_00);
  }

  Future<void> scrollToTime(TimeOfDay time) async {
    isImplicitScrolling = true;
    await Future.wait([
      hoursController.animateToIndex(time.hour),
      minutesController.animateToIndex(time.minute),
    ]);
    isImplicitScrolling = false;
    selectedTime = time;
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
          child: Padding(
            padding: EdgeInsets.all(16.toFigmaSize),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _DialogPickerHeader(
                    title: 'Дата',
                  ),
                  verticalSpacer,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _PickHourListWidget(
                        onHourChanged: (hour) => updateSelectedTime(hour: hour),
                        controller: hoursController,
                      ),
                      spacer,
                      _PickMinutesListWidget(
                        onMinutesChanged: (minutes) => updateSelectedTime(
                          minute: minutes,
                        ),
                        controller: minutesController,
                      ),
                    ],
                  ),
                  verticalSpacer,
                  _SpecficTimePickButtonsGroup(
                    on9Tap: pick9Hour,
                    on12Tap: pick12Hour,
                    on15Tap: pick15Hour,
                    on18Tap: pick18Hour,
                  ),
                  verticalSpacer,
                  PickerConfirmButton(
                    onTap: () {
                      Navigator.of(context).pop(selectedTime);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
