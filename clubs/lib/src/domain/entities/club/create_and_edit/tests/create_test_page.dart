import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:clubs/src/domain/entities/club/create_and_edit/tests/components/checkbox.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/tests/components/checkbox_textfield.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/tests/components/radiobutton_textfield.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/app_bar.dart'; 

part 'questions/questions_form.dart';
part 'questions/answer_options.dart';

class TestForm extends StatefulWidget {
  final bool isEditMode;
  final List<Map<String, dynamic>>? initialQuestions;

  const TestForm({
    super.key,
    this.isEditMode = false,
    this.initialQuestions,
    });

  @override
  TestFormState createState() => TestFormState();
}

class TestFormState extends State<TestForm> {
  bool multipleAnswers = false;  
  String? selectedOption;  
  List<String> selectedOptions = [];

  List<QuestionModel> questions = [];

  void _addQuestion() {
    setState(() {
      questions.add(
        QuestionModel(
          questionController: TextEditingController(),
          optionControllers: [
            TextEditingController(),
            TextEditingController(),
          ],
        ),
      );
    });
  }

    void _addOption(int questionIndex) {
    setState(() {
      questions[questionIndex].optionControllers
          .add(TextEditingController());
    });
  }

  void _deleteOption(int questionIndex, int optionIndex) {
    setState(() {
      final question = questions[questionIndex];

      final removedController = question.optionControllers[optionIndex];
      removedController.dispose();
      question.optionControllers.removeAt(optionIndex);

      question.selectedOptionIndexes = question.selectedOptionIndexes
        .where((i) => i != optionIndex) 
        .map((i) => i > optionIndex ? i - 1 : i) 
        .toList();

      if (question.selectedOptionIndex == optionIndex) {
        question.selectedOptionIndex = null;
      } else if (question.selectedOptionIndex != null && question.selectedOptionIndex! > optionIndex) {
        question.selectedOptionIndex = question.selectedOptionIndex! - 1;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.isEditMode && widget.initialQuestions != null) {
      questions = widget.initialQuestions!.map((q) {
        final questionController = TextEditingController(text: q['text'] ?? '');
        final options = (q['answerOptions'] as List<dynamic>?)?.map((o) => TextEditingController(text: o.toString())).toList() ?? [];

        final answerType = q['answerType'] ?? 'SINGLE';
        final correctIndexes = (q['correctOptionNumbers'] as List<dynamic>?)?.cast<int>() ?? [];

        return QuestionModel(
          questionController: questionController,
          optionControllers: options,
          multipleAnswers: answerType == 'MULTIPLE',
          selectedOptionIndex: answerType == 'SINGLE' && correctIndexes.isNotEmpty ? correctIndexes.first : null,
          selectedOptionIndexes: answerType == 'MULTIPLE' ? correctIndexes : [],
        );
      }).toList();
    } else {
      questions = [
        QuestionModel(
          questionController: TextEditingController(),
          optionControllers: [
            TextEditingController(),
            TextEditingController(),
          ],
        ),
      ];
    }
  }
  
  @override
  void dispose() {
    for (var question in questions) {
      question.questionController.dispose();
      for (var optionController in question.optionControllers) {
        optionController.dispose();
      }
    }
    super.dispose();
  }

  List<Map<String, dynamic>> buildQuestionInputs() {
    return questions.map((question) {
      final text = question.questionController.text.trim();
      final options = question.optionControllers.map((c) => c.text.trim()).toList();
      final answerType = question.multipleAnswers ? 'MULTIPLE' : 'SINGLE';
      final correctOptionNumbers = question.multipleAnswers
          ? question.selectedOptionIndexes
          : question.selectedOptionIndex != null ? [question.selectedOptionIndex!] : [];
      return {
        'text': text,
        'answerOptions': options,
        'answerType': answerType,
        'correctOptionNumbers': correctOptionNumbers,
      };
    }).toList();
  }

  bool validateTestForm(BuildContext context, List<QuestionModel> questions) {
  for (var i = 0; i < questions.length; i++) {
    final question = questions[i];
    final questionText = question.questionController.text.trim();

    if (questionText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Вопрос ${i + 1} не заполнен')),
      );
      return false;
    }

    if (question.optionControllers.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('В вопросе ${i + 1} должно быть минимум 2 варианта ответа')),
      );
      return false;
    }

    for (var j = 0; j < question.optionControllers.length; j++) {
      if (question.optionControllers[j].text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Вариант ${j + 1} в вопросе ${i + 1} пустой')),
        );
        return false;
      }
    }

    if (question.multipleAnswers) {
      if (question.selectedOptionIndexes.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Выберите хотя бы один правильный ответ в вопросе ${i + 1}')),
        );
        return false;
      }
    } else {
      if (question.selectedOptionIndex == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Выберите правильный ответ в вопросе ${i + 1}')),
        );
        return false;
      }
    }
  }

  return true;
}

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.base_0,
      child: SafeArea(
        child: Scaffold(
          appBar: const CreateAndEditPageAppBar(),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 20.toFigmaSize,
              vertical: 4.toFigmaSize,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Создайте свой тест', style: context.textTheme.h4.copyWith(color: context.colors.base_90)),
                SizedBox(height: 12.toFigmaSize),
                Text('Вопросы', style: context.textTheme.bodyXLMedium),
                SizedBox(height: 12.toFigmaSize),
                ...questions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final question = entry.value;

                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.toFigmaSize),
                    child: QuestionForm(
                      questionController: question.questionController,
                      optionControllers: question.optionControllers,
                      multipleAnswers: question.multipleAnswers,
                      selectedOptionIndex: question.selectedOptionIndex,
                      selectedOptionIndexes: question.selectedOptionIndexes,
                      onAddOption: () => _addOption(index),
                      onDeleteQ: () {
                        setState(() {
                          final q = questions.removeAt(index);
                          q.questionController.dispose();
                          for (var oc in q.optionControllers) {
                            oc.dispose();
                          }
                        });
                      },
                      onDeleteOption: (optionIndex) => _deleteOption(index, optionIndex),
                      onMultipleAnswersChanged: (value) {
                        setState(() {
                          question.multipleAnswers = value;
                          question.selectedOptionIndexes = [];
                          question.selectedOptionIndex = null;
                        });
                      },
                      onOptionSelected: (index) {
                        setState(() {
                          question.selectedOptionIndex = index;
                        });
                      },
                      onOptionsSelectedChanged: (newSelected) {
                        setState(() {
                          question.selectedOptionIndexes = newSelected;
                        });
                      },
                    ),
                  );
                }).toList(),

                CustomButton(
                  type: ButtonType.tertiary,
                  customWidth: 200.toFigmaSize,
                  text: "Добавить вопрос",
                  onPressed: _addQuestion,
                  leftIcon: SvgPicture.asset(
                    'packages/clubs/assets/icons/plus.svg',
                    colorFilter: ColorFilter.mode(context.colors.main_50, BlendMode.srcIn),
                    width: 24.toFigmaSize,
                    height: 24.toFigmaSize,
                  ),
                ),

                SizedBox(height: 12.toFigmaSize),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.toFigmaSize, vertical: 4.toFigmaSize),
            child: SizedBox(
              width: double.infinity,
              child: CustomButton(
                size: ButtonSize.M,
                type: ButtonType.primary,
                color: ButtonColor.green,
                text: 'Готово',
                onPressed: () {
                  final isValid = validateTestForm(context, questions);
                  if (!isValid) return;

                  final questionInputs = buildQuestionInputs();
                  
                  Map<String, dynamic> result = {
                    'questionCount': questions.length,
                    'questions': questionInputs,
                  };
                  Navigator.pop(context, result);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
