import 'package:flutter/material.dart';
import 'package:clubs/src/data/clubs_api_service.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

import 'package:clubs/src/domain/entities/club/clubs_pages/common/app_bar.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/alert_dialogs.dart';
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
  Set<int> selectedAnswerIndexes = {};
  final Map<int, List<int>> answersMap = {}; 
  int questionsCount = 0;
  bool isLoading = true;
  String? approvementId;
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

    if (approvements != null && approvements.isNotEmpty) {
      approvementId = approvements.first['id'];

      final questionsJson = approvements.first['data']['questions'] as List<dynamic>;
      setState(() {
        questions = questionsJson.map((q) => Question.fromJson(q)).toList();
        questionsCount = questions.length;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onPrevious() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        _restoreAnswerState();
      });
    }
  }

  void _onNext() {
    if (currentQuestionIndex < questionsCount - 1 && (_isAnswerSelected())) {
      setState(() {
        currentQuestionIndex++;
        _restoreAnswerState();
      });
    }
  }

  void _restoreAnswerState() {
    final currentAnswers = answersMap[currentQuestionIndex];
    selectedAnswerIndexes = currentAnswers != null ? currentAnswers.toSet() : {};
  }

  bool _isAnswerSelected() {
    return selectedAnswerIndexes.isNotEmpty;
  }

  void _onSelectAnswer(String answer) {
    final question = questions[currentQuestionIndex];
    final isMultiple = question.answerType == 'MULTIPLE';
    final optionIndex = question.answerOptions.indexOf(answer);
    
    setState(() {
      if (isMultiple) {
        if (selectedAnswerIndexes.contains(optionIndex)) {
          selectedAnswerIndexes.remove(optionIndex);
        } else {
          selectedAnswerIndexes.add(optionIndex);
        }
        answersMap[currentQuestionIndex] = selectedAnswerIndexes.toList();
      } else {
        selectedAnswerIndexes = {optionIndex};
        answersMap[currentQuestionIndex] = [optionIndex];
      }
    });
  }

  Future<void> _onFinish() async {
    if (approvementId == null) {
      print('Ошибка: approvementId is null');
      return;
    }

    showDialog(
      context: context,
      builder: (_) => ConfirmActionDialog(
        message: 'Завершить тест?',
        subMessage: 'После завершения теста ответы изменить нельзя.',
        confirmText: 'Завершить',
        onConfirm: _submitAnswers,
        customColor: context.colors.main_50,
      ),
    );
  }

  Future<void> _submitAnswers() async {
    final questionAnswers = answersMap.entries.map((entry) {
      return {
        'optionNumbers': entry.value,
      };
    }).toList();

    try {
      final response = await createAnswerForm(
        approvementId: approvementId!,
        questionAnswers: questionAnswers,
        apiService: clubApiService,
      );

      final answerId = response?['createApprovementAnswerForm']?['id'];
      if (answerId != null) {
        await sendAnswersForReview(
          answerId: answerId,
          apiService: clubApiService,
        );
      }

      if (mounted) {
        Navigator.of(context).pop(); // Закрытие экрана после отправки
      }
    } catch (e) {
      print('Ошибка отправки ответов: $e');
    }
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
            selectedAnswerIndexes: selectedAnswerIndexes,
            onSelectAnswer: _onSelectAnswer,
          ),
          bottomNavigationBar: BottomButtons(
            onPrevious: _onPrevious,
            onNext: currentQuestionIndex == questionsCount - 1 ? _onFinish : _onNext,
            canGoBack: currentQuestionIndex > 0,
            canGoNext: _isAnswerSelected(),
            isLastQuestion: currentQuestionIndex == questionsCount - 1,
          ),
        ),
      ),
    );
  }
}
