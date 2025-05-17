import 'package:flutter/material.dart';
import 'package:clubs/src/data/clubs_api_service.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:clubs/src/domain/entities/club/clubs_pages/common/app_bar.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/tests/components/radiobutton.dart';

part 'test_form_body.dart';
part 'bottom_buttons.dart';

class TestFormScreen extends StatefulWidget {
  const TestFormScreen({super.key});

  @override
  State<TestFormScreen> createState() => _TestFormScreenState();
}

class _TestFormScreenState extends State<TestFormScreen> {
  int currentQuestionIndex = 0;
  int totalQuestions = 4;
  String? selectedAnswer;

  void _onPrevious() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        selectedAnswer = null;
      });
    }
  }

  void _onNext() {
    if (currentQuestionIndex < totalQuestions - 1 && selectedAnswer != null) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
      });
    }
  }

  void _onSelectAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.base_0,
      child: SafeArea(
        child: Scaffold(
          appBar: const ClubPageAppBar(title: 'Прохождение теста',),
          body: TestFormBody(
            questionIndex: currentQuestionIndex,
            totalQuestions: totalQuestions,
            selectedAnswer: selectedAnswer,
            onSelectAnswer: _onSelectAnswer,
          ),
          bottomNavigationBar: BottomButtons(
            onPrevious: _onPrevious,
            onNext: _onNext,
            canGoBack: currentQuestionIndex > 0,
            canGoNext: selectedAnswer != null,
            isLastQuestion: currentQuestionIndex == totalQuestions - 1,
          ),
        ),
      ),
    );
  }
}
