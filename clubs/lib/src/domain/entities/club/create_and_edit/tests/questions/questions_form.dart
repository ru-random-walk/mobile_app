part of '../create_test_page.dart';

class QuestionModel {
  final TextEditingController questionController;
  final List<TextEditingController> optionControllers;
  bool multipleAnswers;
  String? selectedOption;
  List<String> selectedOptions;

  QuestionModel({
    required this.questionController,
    required this.optionControllers,
    this.multipleAnswers = false,
    this.selectedOption,
    this.selectedOptions = const [],
  });
}

class QuestionForm extends StatefulWidget {
  final TextEditingController questionController;
  final List<TextEditingController> optionControllers;
  final bool multipleAnswers;
  final String? selectedOption;
  final List<String> selectedOptions;
  final VoidCallback onAddOption;
  final ValueChanged<bool> onMultipleAnswersChanged;
  final ValueChanged<String?> onOptionSelected;
  final ValueChanged<List<String>> onOptionsSelectedChanged;
  final ValueChanged<int> onDeleteOption; 
  final VoidCallback onDeleteQ; 

  const QuestionForm({
    super.key,
    required this.questionController,
    required this.optionControllers,
    required this.multipleAnswers,
    required this.selectedOption,
    required this.selectedOptions,
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
                      option: optionText,
                      multipleAnswers: widget.multipleAnswers,
                      isSelected: widget.selectedOptions.contains(optionText),
                      selectedOption: widget.selectedOption,
                      textController: controller,
                      onCheckboxChanged: (value) {
                        final newOptions = [...widget.selectedOptions];
                        if (value == true) {
                          newOptions.add(optionText);
                        } else {
                          newOptions.remove(optionText);
                        }
                        widget.onOptionsSelectedChanged(newOptions);
                      },
                      onRadioChanged: (value) {
                        widget.onOptionSelected(value);
                      },
                      onDelete: () {
                        widget.onDeleteOption(index);
                      },
                    ),
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
