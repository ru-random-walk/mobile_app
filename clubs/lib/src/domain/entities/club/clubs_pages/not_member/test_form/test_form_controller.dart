part of 'test_form_screen.dart';

class TestFormController {
  final String clubId;
  final VoidCallback onUpdate;
  final ClubApiService clubApiService = ClubApiService();

  List<Question> questions = [];
  Map<int, List<int>> answersMap = {};
  Set<int> selectedIndexes = {};

  int currentIndex = 0;
  bool isLoading = true;
  String? approvementId;

  TestFormController(this.clubId, {required this.onUpdate});

  Question get currentQuestion => questions[currentIndex];
  int get totalQuestions => questions.length;
  bool get canGoBack => currentIndex > 0;
  bool get isAnswerSelected => selectedIndexes.isNotEmpty;
  bool get isLastQuestion => currentIndex == totalQuestions - 1;

   Future<void> loadQuestions() async {
    try {
      final data = await getApprovementInfo(clubId: clubId, apiService: clubApiService);
      final approvements = data?['data']?['getClub']?['approvements'] as List<dynamic>?;

      if (approvements != null && approvements.isNotEmpty) {
        approvementId = approvements.first['id'];
        final questionsJson = approvements.first['data']['questions'] as List<dynamic>;
        questions = questionsJson
            .map((q) => Question.fromJson(q as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print('Ошибка при загрузке вопросов: $e');
    } finally {
      isLoading = false;
      onUpdate();
    }
  }

  void onPrevious() {
    if (canGoBack) {
      currentIndex--;
      _restoreSelectedIndexes();
      onUpdate();
    }
  }

  void onNext() {
    if (!isLastQuestion && isAnswerSelected) {
      currentIndex++;
      _restoreSelectedIndexes();
      onUpdate();
    }
  }

  void selectAnswer(String answer) {
    final question = questions[currentIndex];
    final isMultiple = question.answerType == 'MULTIPLE';
    final index = question.answerOptions.indexOf(answer);

    if (isMultiple) {
      if (selectedIndexes.contains(index)) {
        selectedIndexes.remove(index);
      } else {
        selectedIndexes.add(index);
      }
      answersMap[currentIndex] = selectedIndexes.toList();
    } else {
      selectedIndexes = {index};
      answersMap[currentIndex] = [index];
    }

    onUpdate();
  }

  void _restoreSelectedIndexes() {
    final saved = answersMap[currentIndex];
    selectedIndexes = saved != null ? saved.toSet() : {};
  }

  Future<void> finish(BuildContext context) async {
    if (approvementId == null) return;

    showDialog(
      context: context,
      builder: (_) => ConfirmActionDialog(
        message: 'Завершить тест?',
        subMessage: 'После завершения теста ответы изменить нельзя.',
        confirmText: 'Завершить',
        onConfirm: () {
          _submitAnswers(context, sendForReview: true);
        },
        customColor: context.colors.main_50,
      ),
    );
  }

  Future<void> _submitAnswers(BuildContext context, {required bool sendForReview}) async {
    final questionAnswers = answersMap.entries.map((e) => {
          'optionNumbers': e.value,
        }).toList();

    try {
      final response = await createAnswerForm(
        approvementId: approvementId!,
        questionAnswers: questionAnswers,
        apiService: clubApiService,
      );

      if (handleGraphQLErrors(context, response, fallbackMessage: 'Ошибка завершения теста')) return;

      final answerId = response?['data']?['createApprovementAnswerForm']?['id'];
      String? status;

      if (sendForReview && answerId != null) {
        final result = await sendAnswers(
          answerId: answerId,
          apiService: clubApiService,
        );
        if (handleGraphQLErrors(context, result, fallbackMessage: 'Ошибка отправки ответов')) return;
       
        status = result?['data']['setAnswerStatusToSent']?['status'];
      }

      final result = await tryJoinInClub(
          userId: answerId,
          clubId: clubId,
          apiService: clubApiService,
        );
      if (handleGraphQLErrors(context, result, fallbackMessage: 'Не получилось вступить в группу')) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ответы отправлены'),
          backgroundColor: context.colors.main_50,
        ),
      );

      if (context.mounted) {
        Navigator.of(context).pop(status == 'PASSED');
      }
    } catch (e) {
      print(e);
      showErrorSnackbar(context, 'Произошла ошибка');
    } 
  }
}
