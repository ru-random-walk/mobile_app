part of '../../page.dart';

class _MeetDataDialogWidget extends StatefulWidget {
  @override
  State<_MeetDataDialogWidget> createState() => _MeetDataDialogWidgetState();
}

class _MeetDataDialogWidgetState extends State<_MeetDataDialogWidget> {
  DateTime? selectedDate;

  TimeOfDay? selectedTime;

  Geolocation? geolocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Dialog(
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
                          child: PickerConfirmButton(
                            onTap: () {
                              if (allFieldsFilled) {
                                final pickedDate = selectedDate!.add(
                                  Duration(
                                    hours: selectedTime!.hour,
                                    minutes: selectedTime!.minute,
                                  ),
                                );
                                if (pickedDate.isBefore(DateTime.now())) {
                                  final snackBar = SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      'Выбранная дата уже прошла',
                                      style:
                                          context.textTheme.bodyMRegularBase90,
                                    ),
                                    backgroundColor: context.colors.base_0,
                                    duration:
                                        const Duration(milliseconds: 1500),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  return;
                                }
                                final invite = InviteEntity(
                                  date: selectedDate!,
                                  time: selectedTime!,
                                  place: geolocation!,
                                );
                                Navigator.of(context).pop(invite);
                              } else {
                                final snackBar = SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    'Заполните все поля',
                                    style: context.textTheme.bodyMRegularBase90,
                                  ),
                                  backgroundColor: context.colors.base_0,
                                  duration: const Duration(milliseconds: 1500),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool get allFieldsFilled =>
      selectedDate != null && selectedTime != null && geolocation != null;
}
