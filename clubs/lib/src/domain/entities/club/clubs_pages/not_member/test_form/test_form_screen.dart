import 'package:flutter/material.dart';
import 'package:clubs/src/data/clubs_api_service.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:clubs/src/domain/entities/club/clubs_pages/common/app_bar.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/tests/components/radiobutton.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/tests/components/checkbox.dart';

part 'test_form_body.dart';
part 'bottom_buttons.dart';
part 'qustion.dart';

class TestFormScreen extends StatefulWidget {
  final String clubId;

  const TestFormScreen({
    super.key,
    required this.clubId,
  });

  @override
  State<TestFormScreen> createState() => _TestFormScreenState();
}

class _TestFormScreenState extends State<TestFormScreen> {
  int currentQuestionIndex = 0;
  List<Question> questions = [];
  String? selectedAnswer;
  Set<String> selectedAnswers = {};
  int questionsCount = 0;
  bool isLoading = true;
  ClubApiService clubApiService = ClubApiService();

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final clubId = widget.clubId;

    final data = await getApprovementInfo(clubId: clubId, apiService: clubApiService);
    final approvements = data?['getClub']?['approvements'] as List<dynamic>?;

    if (approvements != null) {
      if (approvements.isNotEmpty) {
        final questionsJson = approvements.first['data']['questions'] as List<dynamic>;
        setState(() {
          questions = questionsJson.map((q) => Question.fromJson(q)).toList();
          questionsCount = questions.length;
          isLoading = false;
        });
      }
    }
  }

  void _onPrevious() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        selectedAnswer = null;
        selectedAnswers.clear();
      });
    }
  }

  void _onNext() {
    if (currentQuestionIndex < questionsCount - 1 && (_isAnswerSelected())) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        selectedAnswers.clear();
      });
    }
  }

  bool _isAnswerSelected() {
    final isMultiple = questions[currentQuestionIndex].answerType == 'MULTIPLE';
    return isMultiple ? selectedAnswers.isNotEmpty : selectedAnswer != null;
  }

  void _onSelectAnswer(String answer) {
    final isMultiple = questions[currentQuestionIndex].answerType == 'MULTIPLE';
    
    setState(() {
      if (isMultiple) {
        if (selectedAnswers.contains(answer)) {
          selectedAnswers.remove(answer);
        } else {
          selectedAnswers.add(answer);
        }
      } else {
        selectedAnswer = answer;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ColoredBox(
      color: context.colors.base_0,
      child: SafeArea(
        child: Scaffold(
          appBar: const ClubPageAppBar(title: 'Прохождение теста',),
          body: TestFormBody(
            question: questions[currentQuestionIndex],
            questionIndex: currentQuestionIndex,
            totalQuestions: questionsCount,
            selectedAnswer: selectedAnswer,
            selectedAnswers: selectedAnswers,
            onSelectAnswer: _onSelectAnswer,
          ),
          bottomNavigationBar: BottomButtons(
            onPrevious: _onPrevious,
            onNext: _onNext,
            canGoBack: currentQuestionIndex > 0,
            canGoNext: _isAnswerSelected(),
            isLastQuestion: currentQuestionIndex == questionsCount - 1,
          ),
        ),
      ),
    );
  }
}
