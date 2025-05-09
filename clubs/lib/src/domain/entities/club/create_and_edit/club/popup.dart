part of '../create_club_page.dart';

class _AddTestDialog extends StatelessWidget {
  final void Function(String, int, String, List<Map<String, dynamic>>? questions) onConditionAdded;
  final int infoCount;
  final String conditionName;

  const _AddTestDialog({
    required this.onConditionAdded,
    required this.infoCount,
    required this.conditionName,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.toFigmaSize),
      ),
      contentPadding: EdgeInsets.all(8.toFigmaSize),
      content: SizedBox(
        width: 360.toFigmaSize,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 8.toFigmaSize,
                bottom: 4.toFigmaSize,
                left: 12.toFigmaSize,
                top: 4.toFigmaSize,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Добавить проверку',
                      style: context.textTheme.h5,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: context.colors.base_30),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.toFigmaSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomButton(
                    size: ButtonSize.M,
                    type: ButtonType.primary,
                    color: ButtonColor.green,
                    text: 'Тест',
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TestForm()),
                      ).then((result) {
                        if (result != null) {
                          String attempts = result['attempts'];
                          String testName = result['testName'];
                          int questionCount = result['questionCount'];
                          List<Map<String, dynamic>> questionInputs = result['questions'];

                          // Обновление состояния на GroupFormScreen
                          onConditionAdded(attempts, questionCount, testName, questionInputs);
                        }
                      });
                    },
                  ),
                  SizedBox(height: 16.toFigmaSize),
                  CustomButton(
                    size: ButtonSize.M,
                    type: ButtonType.primary,
                    color: ButtonColor.green,
                    text: 'Подтверждение от инспекторов',
                    onPressed: () {
                      Navigator.pop(context); 
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return _InspectorConfDialog(onInspectorConfirmed: (inspectorCount) {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return _NumberInputDialog(
                                  onConditionAdded: (String attempts, int inspectorCountFromDialog) {
                                    onConditionAdded(attempts, inspectorCountFromDialog, "Запрос на вступление", null);
                                  },
                                  inspectorCount: inspectorCount,
                                );
                              },
                            );
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _InspectorConfDialog extends StatefulWidget {
  final ValueChanged<int> onInspectorConfirmed;

  const _InspectorConfDialog({required this.onInspectorConfirmed});

  @override
  State<_InspectorConfDialog> createState() => _InspectorConfDialogState();
}

class _InspectorConfDialogState extends State<_InspectorConfDialog> {
  int inspectorCount = 1;

  void _increment() {
    setState(() {
      inspectorCount++;
    });
  }

  void _decrement() {
    setState(() {
      if (inspectorCount > 1) {
        inspectorCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.toFigmaSize),
      ),
      contentPadding: EdgeInsets.all(12.toFigmaSize),
      content: SizedBox(
        width: 360.toFigmaSize,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, color: context.colors.base_30),
                ),
              ],
            ),
            Text('Укажите число', style: context.textTheme.h5),
            SizedBox(height: 16.toFigmaSize),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.toFigmaSize),
              child: Text(
                'Количество инспекторов и администраторов, которым будут приходить запросы на вступление',
                style: context.textTheme.bodyMItalic.copyWith(color: context.colors.base_50),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8.toFigmaSize),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  size: ButtonSize.M,
                  type: ButtonType.tertiary,
                  color: ButtonColor.green,
                  leftIcon: SvgPicture.asset(
                    'packages/clubs/assets/icons/minus.svg',
                    colorFilter: ColorFilter.mode(
                      inspectorCount == 1 ? context.colors.base_30 : context.colors.main_50,
                      BlendMode.srcIn,
                    ),
                    width: 24.toFigmaSize,
                    height: 24.toFigmaSize,
                  ),
                  text: null,
                  customWidth: 48.toFigmaSize,
                  customHeight: 48.toFigmaSize,
                  onPressed: inspectorCount > 1 ? _decrement : null,
                ),
                SizedBox(width: 16.toFigmaSize),
                Text(
                  '$inspectorCount',
                  style: context.textTheme.h5,
                ),
                SizedBox(width: 16.toFigmaSize),
                CustomButton(
                  size: ButtonSize.M,
                  type: ButtonType.tertiary,
                  color: ButtonColor.green,
                  leftIcon: SvgPicture.asset(
                    'packages/clubs/assets/icons/plus.svg',
                    colorFilter: ColorFilter.mode(
                      inspectorCount == 10 ? context.colors.base_30 : context.colors.main_50,
                      BlendMode.srcIn,
                    ),
                    width: 24.toFigmaSize,
                    height: 24.toFigmaSize,
                  ),
                  text: null,
                  customWidth: 48.toFigmaSize,
                  customHeight: 48.toFigmaSize,
                  onPressed: inspectorCount < 10 ? _increment : null,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.toFigmaSize, vertical: 4.toFigmaSize),
              child: Text(
                'Число не может превышать количество инспекторов и администраторов в группе',
                style: context.textTheme.captionItalic.copyWith(color: context.colors.base_50),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.toFigmaSize, vertical: 8.toFigmaSize),
              child: CustomButton(
                size: ButtonSize.M,
                type: ButtonType.primary,
                color: ButtonColor.green,
                text: 'Готово',
                onPressed: () {
                  widget.onInspectorConfirmed(inspectorCount);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _NumberInputDialog extends StatelessWidget {
  final TextEditingController controller = TextEditingController(text: '1');
  final void Function(String, int) onConditionAdded;
  final int inspectorCount;

  _NumberInputDialog({
    required this.onConditionAdded,
    required this.inspectorCount,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.toFigmaSize),
      ),
      contentPadding: EdgeInsets.all(12.toFigmaSize),
      content: SizedBox(
        width: 360.toFigmaSize,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, color: context.colors.base_30),
                ),
              ],
            ),
            Text('Введите количество попыток', style: context.textTheme.h5),
            SizedBox(height: 16.toFigmaSize),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 48.toFigmaSize,
                child: CustomTextField(
                  radius: 6.toFigmaSize,
                  controller: controller,
                  height: 20.toFigmaSize,
                  maxLines: 1,
                  textStyle: context.textTheme.bodyMRegularBase90,
                ),
              ),
            ),
            SizedBox(height: 16.toFigmaSize),
            CustomButton(
              size: ButtonSize.M,
              type: ButtonType.primary,
              color: ButtonColor.green,
              text: 'Готово',
              onPressed: () {
                onConditionAdded(controller.text, inspectorCount);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
