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
  const TestForm({super.key});

  @override
  TestFormState createState() => TestFormState();
}

class TestFormState extends State<TestForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController attemptController = TextEditingController(text: '1');
  //final TextEditingController questionController = TextEditingController();
  bool multipleAnswers = false;  
  String? selectedOption;  
  List<String> selectedOptions = [];

  List<QuestionModel> questions = [
    QuestionModel(
      questionController: TextEditingController(),
      optionControllers: [
        TextEditingController(text: 'Супер-быстрый темп'),
        TextEditingController(text: 'Красивые места'),
        TextEditingController(text: 'Солнечная погода'),
      ],
    ),
  ];
  void _addQuestion() {
    setState(() {
      questions.add(
        QuestionModel(
          questionController: TextEditingController(),
          optionControllers: [
            TextEditingController(text: 'Новый вариант 1'),
          ],
        ),
      );
    });
  }

    void _addOption(int questionIndex) {
    setState(() {
      questions[questionIndex].optionControllers
          .add(TextEditingController(text: 'Новый вариант ${questions[questionIndex].optionControllers.length + 1}'));
    });
  }
  void _deleteOption(int questionIndex, int optionIndex) {
    setState(() {
      final question = questions[questionIndex];
      final removedOption = question.optionControllers[optionIndex].text;
      question.optionControllers[optionIndex].dispose();
      question.optionControllers.removeAt(optionIndex);

      question.selectedOptions.remove(removedOption);
      if (question.selectedOption == removedOption) {
        question.selectedOption = null;
      }
    });
  }

  
  @override
  void dispose() {
    nameController.dispose();
    attemptController.dispose();
    for (var question in questions) {
      question.questionController.dispose();
      for (var optionController in question.optionControllers) {
        optionController.dispose();
      }
    }
    super.dispose();
  }

  // List<TextEditingController> optionControllers = [
  //   TextEditingController(text: 'Супер-быстрый темп'),
  //   TextEditingController(text: 'Красивые места'),
  //   TextEditingController(text: 'Солнечная погода'),
  // ];


//   void _addOption() {
//   setState(() {
//     optionControllers.add(TextEditingController(text: 'Новый вариант ${optionControllers.length + 1}'));
//   });
// }

// void _deleteOption(int index) {
//     setState(() {
//       final removedOption = optionControllers[index].text;
//       optionControllers[index].dispose(); // обязательно очищаем контроллер
//       optionControllers.removeAt(index);

//       // ещё надо убрать выбранный ответ, если он был удалён
//       selectedOptions.remove(removedOption);
//       if (selectedOption == removedOption) {
//         selectedOption = null;
//       }
//     });
//   }

  // @override
  // void dispose() {
  //   // очищаем все контроллеры при закрытии экрана
  //   nameController.dispose();
  //   attemptController.dispose();
  //   questionController.dispose();
  //   for (final controller in optionControllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }


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
                Text('Название теста', style: context.textTheme.bodyXLMedium),
                SizedBox(height: 8.toFigmaSize),
                CustomTextField(
                  height: 36.toFigmaSize,
                  maxLines: 1,
                  controller: nameController,
                  hint: 'Название',
                  radius: 6.toFigmaSize,
                  textStyle: context.textTheme.bodyMRegularBase90,
                ),
                SizedBox(height: 16.toFigmaSize),
                Text('Количество попыток', style: context.textTheme.bodyXLMedium),
                SizedBox(height: 8.toFigmaSize),
                CustomTextField(
                  height: 36.toFigmaSize,
                  maxLines: 1,
                  controller: attemptController,
                  radius: 6.toFigmaSize,
                  textStyle: context.textTheme.bodyMRegularBase90,
                ),
                SizedBox(height: 16.toFigmaSize),
                Text('Вопросы', style: context.textTheme.bodyXLMedium),
                SizedBox(height: 12.toFigmaSize),

                // Список всех вопросов
                ...questions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final question = entry.value;


                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.toFigmaSize),
                    child: QuestionForm(
                      questionController: question.questionController,
                      optionControllers: question.optionControllers,
                      multipleAnswers: multipleAnswers,
                      selectedOption: selectedOption,
                      selectedOptions: selectedOptions,
                      onAddOption: () => _addOption(index),
                      onDeleteQ: () => {},
                      onDeleteOption: (optionIndex) => _deleteOption(index, optionIndex),
                      onMultipleAnswersChanged: (value) {
                        setState(() {
                          question.multipleAnswers = value;
                          question.selectedOptions.clear();
                          question.selectedOption = null;
                        });
                      },
                      onOptionSelected: (value) {
                        setState(() {
                          question.selectedOption = value;
                        });
                      },
                      onOptionsSelectedChanged: (newSelected) {
                        setState(() {
                          question.selectedOptions = newSelected;
                        });
                      },
                    ),
                  );
                }).toList(),


                CustomButton(
                  type: ButtonType.tertiary,
                  customWidth: 250.toFigmaSize,
                  text: "Добавить вопрос",
                  onPressed: _addQuestion,
                  leftIcon: SvgPicture.asset(
                    'packages/clubs/assets/icons/plus.svg',
                    colorFilter: ColorFilter.mode(context.colors.main_50, BlendMode.srcIn),
                    width: 24.toFigmaSize,
                    height: 24.toFigmaSize,
                  ),
                ),

                // QuestionForm(
                //   questionController: questionController,
                //   optionControllers: optionControllers,
                //   multipleAnswers: multipleAnswers,
                //   selectedOption: selectedOption,
                //   selectedOptions: selectedOptions,
                //   onAddOption: _addOption,
                //   onDeleteOption: _deleteOption,
                //   onMultipleAnswersChanged: (value) {
                //     setState(() {
                //       multipleAnswers = value;
                //       selectedOptions.clear();
                //       selectedOption = null;
                //     });
                //   },
                //   onOptionSelected: (value) {
                //     setState(() {
                //       selectedOption = value;
                //     });
                //   },
                //   onOptionsSelectedChanged: (newSelected) {
                //     setState(() {
                //       selectedOptions = newSelected;
                //     });
                //   },
                // ),




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
                  //нажатие кнопки
                },
              ),
            ),
          ),
        ),
      ),
    
    );
  }
}
