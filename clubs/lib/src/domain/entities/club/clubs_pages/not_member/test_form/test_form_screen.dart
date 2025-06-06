import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:clubs/src/data/clubs_api_service.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

import 'package:clubs/src/domain/entities/club/clubs_pages/common/app_bar.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/alert_dialogs.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/tests/components/radiobutton.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/tests/components/checkbox.dart';
import 'package:clubs/utils/qraphql_error_utils.dart';

part 'test_form_body.dart';
part 'bottom_buttons.dart';
part 'qustion.dart';
part 'test_form_controller.dart';

class TestFormScreen extends StatefulWidget {
  final String clubId;
  final String userId;
  final String? answerId;
  final Map<int, List<int>>? savedAnswers;

  const TestFormScreen({
    super.key,
    required this.clubId,
    required this.userId,
    this.answerId,
    this.savedAnswers,
  });

  @override
  State<TestFormScreen> createState() => _TestFormScreenState();
}

class _TestFormScreenState extends State<TestFormScreen> {
  late final TestFormController controller;

  @override
  void initState() {
    super.initState();
    controller = TestFormController(
      widget.clubId, 
      userId: widget.userId,
      savedAnswers: widget.savedAnswers,
      answerId: widget.answerId,
      onUpdate: () => setState(() {}));
    controller.loadQuestions();
  }

   Future<bool> _onExitPressed() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (_) => ConfirmActionDialog(
        message: 'Покинуть тест?',
        subMessage: 'Ваши ответы будут сохранены.',
        confirmText: 'Выйти',
        onConfirm: () async {
          await controller._submitAnswers(context, sendForReview: false);
          if (!mounted) return;
          Navigator.of(context).pop();   
        },
      ),
    );
    return shouldExit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    // ignore: deprecated_member_use
    return WillPopScope(

      onWillPop: _onExitPressed,
      child: ColoredBox(
        color: context.colors.base_0,
        child: SafeArea(
          child: Scaffold(
            appBar: ClubPageAppBar(
              title: 'Прохождение теста',
              onBackPressed: _onExitPressed,
              ),
            body: TestFormBody(
              question: controller.currentQuestion,
              questionIndex: controller.currentIndex,
              totalQuestions: controller.totalQuestions,
              selectedAnswerIndexes: controller.selectedIndexes,
              onSelectAnswer: controller.selectAnswer,
            ),
            bottomNavigationBar: BottomButtons(
              onPrevious: controller.onPrevious,
              onNext: controller.isLastQuestion
                  ? () => controller.finish(context)
                  : controller.onNext,
              canGoBack: controller.canGoBack,
              canGoNext: controller.isAnswerSelected,
              isLastQuestion: controller.isLastQuestion,
            ),
          ),
        ),
      ),
    );
  }
}
