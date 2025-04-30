part of '../create_test_page.dart';

class AnswerOption extends StatelessWidget {
  final String option;
  final bool multipleAnswers;
  final bool isSelected;
  final String? selectedOption;
  final ValueChanged<bool?> onCheckboxChanged;
  final ValueChanged<String?> onRadioChanged;
  final VoidCallback onDelete; 
  final TextEditingController textController;
  final int optionIndex;

  const AnswerOption({
    super.key,
    required this.option,
    required this.multipleAnswers,
    required this.isSelected,
    required this.onCheckboxChanged,
    required this.onRadioChanged,
    required this.onDelete,
    required this.textController,
    this.selectedOption,
    required this.optionIndex,
  });

  @override
Widget build(BuildContext context) {
  return Row(
    children: [
      SizedBox(width: 24.toFigmaSize),
      Expanded(
        child: multipleAnswers
            ? CustomCheckboxTextField(
                value: isSelected,
                onChanged: onCheckboxChanged,
                textController: textController,
                hintText: "Вариант ответа",
              )
            : CustomRadioButtonTextField(
                value: optionIndex.toString(),
                groupValue: selectedOption?.toString(),
                onChanged: onRadioChanged,
                textController: textController,
                hintText: "Вариант ответа",
              ),
      ),
      IconButton(
        icon: Icon(Icons.close, size: 24.toFigmaSize, color: context.colors.base_40),
        onPressed: onDelete,
      ),
    ],
  );
}
}
