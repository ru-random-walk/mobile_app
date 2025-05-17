part of 'test_form_screen.dart';

class TestFormBody extends StatelessWidget {
  final Question question;
  final int questionIndex;
  final int totalQuestions;
  final String? selectedAnswer;
  final Set<String> selectedAnswers;
  final void Function(String) onSelectAnswer;

  const TestFormBody({
    super.key,
    required this.question,
    required this.questionIndex,
    required this.totalQuestions,
    required this.selectedAnswer,
    required this.selectedAnswers,
    required this.onSelectAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: 4.toFigmaSize,
            horizontal: 20.toFigmaSize,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Вопрос ${questionIndex + 1} из $totalQuestions',
                      style: context.textTheme.bodyLMedium.copyWith(
                        color: context.colors.base_70,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.toFigmaSize),
                  ExpandedSection(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8.toFigmaSize),
                      decoration: BoxDecoration(
                        color: context.colors.main_5,
                        borderRadius: BorderRadius.circular(16.toFigmaSize),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha((255 * 0.15).round()),
                            offset: const Offset(0, 4), 
                            blurRadius: 4, 
                            spreadRadius: 0,
                          ),
                        ],
                      ),           
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.toFigmaSize,
                        vertical: 20.toFigmaSize,
                      ),             
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                            question.text,
                              style: context.textTheme.bodyXLMedium.copyWith(
                                color: context.colors.base_90,),
                            ),
                          ),
                          SizedBox(height: 20.toFigmaSize),
                          ...question.answerOptions.map((option) {
                            if (question.answerType == 'MULTIPLE') {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 12.toFigmaSize),
                                child: CustomCheckbox(
                                  value: selectedAnswers.contains(option),
                                  onChanged: (_) => onSelectAnswer(option),
                                  label: option,
                                  labelStyle: context.textTheme.bodyLRegular.copyWith(
                                    color: context.colors.base_70,
                                  ),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 16.toFigmaSize),
                                child: CustomRadioButton(
                                  value: option,
                                  groupValue: selectedAnswer,
                                  onChanged: (value) => onSelectAnswer(value!),
                                  label: option,
                                  labelStyle: context.textTheme.bodyLRegular.copyWith(
                                    color: context.colors.base_70,),
                                ),
                              );
                            }
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ExpandedSection extends StatelessWidget {
  final Widget child;
  const ExpandedSection({required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.topCenter,
        child: child,
      ),
    );
  }
}
