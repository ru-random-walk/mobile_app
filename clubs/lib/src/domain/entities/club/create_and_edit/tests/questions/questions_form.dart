part of '../create_test_page.dart';

class QuestionModel {
  final TextEditingController questionController;
  final List<TextEditingController> optionControllers;
  bool multipleAnswers;
  int? selectedOptionIndex;
  List<int> selectedOptionIndexes;

  QuestionModel({
    required this.questionController,
    required this.optionControllers,
    this.multipleAnswers = false,
    this.selectedOptionIndex,
    this.selectedOptionIndexes = const [],
  });
}

class QuestionForm extends StatefulWidget {
  final TextEditingController questionController;
  final List<TextEditingController> optionControllers;
  final bool multipleAnswers;
  final int? selectedOptionIndex;
  final List<int> selectedOptionIndexes;
  final VoidCallback onAddOption;
  final ValueChanged<bool> onMultipleAnswersChanged;
  final ValueChanged<int?> onOptionSelected;
  final ValueChanged<List<int>> onOptionsSelectedChanged;
  final ValueChanged<int> onDeleteOption; 
  final VoidCallback onDeleteQ; 

  const QuestionForm({
    super.key,
    required this.questionController,
    required this.optionControllers,
    required this.multipleAnswers,
    required this.selectedOptionIndex,
    required this.selectedOptionIndexes,
    required this.onAddOption,
    required this.onMultipleAnswersChanged,
    required this.onOptionSelected,
    required this.onOptionsSelectedChanged,
    required this.onDeleteOption,
    required this.onDeleteQ,
  });

  @override
  State<QuestionForm> createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.toFigmaSize),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(6.toFigmaSize),
        border: Border(
          top: BorderSide(color: context.colors.base_10, width: 1),
          left: BorderSide(color: context.colors.base_10, width: 1),
          right: BorderSide(color: context.colors.base_10, width: 1),
          bottom: BorderSide(color: context.colors.base_10, width: 2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  height: 36.toFigmaSize,
                  maxLines: 1,
                  controller: widget.questionController,
                  radius: 6.toFigmaSize,
                  textStyle: context.textTheme.bodyMRegularBase90,
                  hint: "Вопрос",
                ),),
              SizedBox(height: 20.toFigmaSize),
              IconButton(
                icon: Icon(Icons.close, size: 24.toFigmaSize, color: context.colors.base_40),
                onPressed: widget.onDeleteQ,
              ),],),
          SizedBox(height: 8.toFigmaSize),
          CustomCheckbox(
            label: "Несколько вариантов ответа",
            value: widget.multipleAnswers,
            onChanged: (value) {
              widget.onMultipleAnswersChanged(value ?? false);
            },
          ),
          SizedBox(height: 8.toFigmaSize),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicWidth(
                child: Text(
                  "Правильный\nответ",
                  style: context.textTheme.captionRegular.copyWith(color: context.colors.base_60),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
              SizedBox(height: 4.toFigmaSize),
              Column(
                children: widget.optionControllers.asMap().entries.map((entry) {
                  final index = entry.key;
                  final controller = entry.value;
                  final optionText = controller.text;
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.toFigmaSize),
                    child: AnswerOption(
                      optionIndex: index,
                      option: optionText,
                      multipleAnswers: widget.multipleAnswers,
                      isSelected: widget.selectedOptionIndexes.contains(index),
                      selectedOption: widget.selectedOptionIndex?.toString(),
                      textController: controller,
                      onCheckboxChanged: (value) {
                        final newSelectedIndexes = [...widget.selectedOptionIndexes];
                        if (value == true) {
                          newSelectedIndexes.add(index);
                        } else {
                          newSelectedIndexes.remove(index);
                        }
                        widget.onOptionsSelectedChanged(newSelectedIndexes);
                      },
                      onRadioChanged: (value) {
                        widget.onOptionSelected(index);
                      },
                      onDelete: () {
                        widget.onDeleteOption(index);
                      },
                    )
                  );
                }).toList(),
              ),
              SizedBox(height: 4.toFigmaSize),
              CustomButton(
                type: ButtonType.tertiary,
                customWidth: 200.toFigmaSize,
                leftIcon: SvgPicture.asset(
                  'packages/clubs/assets/icons/plus.svg',
                  colorFilter: ColorFilter.mode(context.colors.main_50, BlendMode.srcIn),
                  width: 24.toFigmaSize,
                  height: 24.toFigmaSize,
                ),
                text: "Добавить вариант",
                onPressed: widget.onAddOption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
