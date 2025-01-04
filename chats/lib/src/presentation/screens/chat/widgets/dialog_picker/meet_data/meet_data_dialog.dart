part of '../../../page.dart';

class _MeetDataDialogWidget extends StatefulWidget {
  @override
  State<_MeetDataDialogWidget> createState() => _MeetDataDialogWidgetState();
}

class _MeetDataDialogWidgetState extends State<_MeetDataDialogWidget> {
  DateTime? selectedDate;

  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 270.toFigmaSize,
        width: 351.toFigmaSize,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.base_0,
            borderRadius: BorderRadius.circular(16.toFigmaSize),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.toFigmaSize),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _MeetPickDataDialogCloseButton(),
                  _MeetDataPickersGroupWidget(),
                  SizedBox(
                    height: 16.toFigmaSize,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 9.toFigmaSize,
                    ),
                    child: PickerConfirmButton(),
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
