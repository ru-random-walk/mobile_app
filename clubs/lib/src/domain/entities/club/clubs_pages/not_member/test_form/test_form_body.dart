part of 'test_form_screen.dart';

class TestFormBody extends StatelessWidget {

  final int questionIndex;
  final int totalQuestions;
  final String? selectedAnswer;
  final void Function(String) onSelectAnswer;

  const TestFormBody({
    super.key,
    required this.questionIndex,
    required this.totalQuestions,
    required this.selectedAnswer,
    required this.onSelectAnswer,
  });

//   @override
//   State<TestFormBody> createState() => _TestFormBody();
// }

//class _TestFormBody extends State<TestFormBody> {
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
                            'Кто пишет стихи?',
                              style: context.textTheme.bodyXLMedium.copyWith(
                                color: context.colors.base_90,),
                            ),
                          ),
                          SizedBox(height: 20.toFigmaSize),
                          CustomRadioButton(
                            value: 'Бараш',
                            groupValue: selectedAnswer,
                            onChanged: (value) => onSelectAnswer(value!),
                            label: 'Бараш',
                            labelStyle: context.textTheme.bodyLRegular.copyWith(
                              color: context.colors.base_70,),
                          ),
                          SizedBox(height: 16.toFigmaSize),
                          CustomRadioButton(
                            value: 'Совунья',
                            groupValue: selectedAnswer,
                            onChanged: (value) => onSelectAnswer(value!),
                            label: 'Совунья',
                            labelStyle: context.textTheme.bodyLRegular.copyWith(
                              color: context.colors.base_70,),
                          ),
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
