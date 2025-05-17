part of 'test_form_screen.dart';

class BottomButtons extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool canGoBack;
  final bool canGoNext;
  final bool isLastQuestion;

  const BottomButtons({
    super.key,
    required this.onPrevious,
    required this.onNext,
    required this.canGoBack,
    required this.canGoNext,
    required this.isLastQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.toFigmaSize,
        horizontal: 24.toFigmaSize,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
            text: "",
            leftIcon: const Icon(Icons.arrow_back_ios_new),
            customHeight: 48.toFigmaSize,
            customWidth: 100.toFigmaSize,
            onPressed: canGoBack ? onPrevious : null,
            customColor: canGoBack
                ? null
                : context.colors.base_20,
            ),
            CustomButton(
            text: isLastQuestion ? "Завершить" : "",
            leftIcon: isLastQuestion
                ? null
                : const Icon(Icons.arrow_forward_ios),
            padding: EdgeInsets.all(4.toFigmaSize),
            customHeight: 48.toFigmaSize,
            customWidth: isLastQuestion ? 132.toFigmaSize : 100.toFigmaSize,
            customColor: canGoNext
                ? null
                : context.colors.base_20,
            onPressed: canGoNext ? onNext : null,
            )
        ],
      ),
    );
  }
}