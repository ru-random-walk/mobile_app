part of '../create_club_page.dart';

class _AddTestDialog extends StatelessWidget {
  final void Function(String, int, List<Map<String, dynamic>>? questions) onConditionAdded;
  final int infoCount;
  final String conditionName;
  final int inspectorAndAdminCount;

  const _AddTestDialog({
    required this.onConditionAdded,
    required this.infoCount,
    required this.conditionName,
    required this.inspectorAndAdminCount,
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
                          String approvementName = 'Тест';
                          int questionCount = result['questionCount'];
                          List<Map<String, dynamic>> questionInputs = result['questions'];

                          onConditionAdded(approvementName, questionCount, questionInputs);
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
                          return _InspectorConfDialog(
                            inspectorAndAdminCount: inspectorAndAdminCount,
                            initialCount: 1,
                            onInspectorConfirmed: (inspectorCount) {
                              Navigator.pop(context);
                              String approvementName = "Запрос на вступление";
                              int count = inspectorCount;
                              onConditionAdded(approvementName, count, null);
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
  final int inspectorAndAdminCount;
  final int initialCount;

  const _InspectorConfDialog({
    required this.onInspectorConfirmed,
    required this.inspectorAndAdminCount,
    required this.initialCount,
  });

  @override
  State<_InspectorConfDialog> createState() => _InspectorConfDialogState();
}

class _InspectorConfDialogState extends State<_InspectorConfDialog> {
  late int inspectorCount;

  @override
  void initState() {
    super.initState();
    inspectorCount = widget.initialCount;
  }

  void _increment() {
    if (inspectorCount < widget.inspectorAndAdminCount) {
      setState(() {
        inspectorCount++;
      });
    }
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
                      inspectorCount == widget.inspectorAndAdminCount 
                        ? context.colors.base_30 
                        : context.colors.main_50,
                      BlendMode.srcIn,
                    ),
                    width: 24.toFigmaSize,
                    height: 24.toFigmaSize,
                  ),
                  text: null,
                  customWidth: 48.toFigmaSize,
                  customHeight: 48.toFigmaSize,
                  onPressed: inspectorCount < widget.inspectorAndAdminCount ? _increment : null,
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
