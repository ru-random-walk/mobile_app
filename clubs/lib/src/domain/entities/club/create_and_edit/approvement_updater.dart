part of 'create_club_page.dart';

class ApprovementUpdater {

  static Future<void> handleConditionUpdate({
    required BuildContext context,
    required ClubApiService apiService,
    required String clubId,
    required bool initialIsConditionAdded,
    required bool isConditionAdded,
    required String? initialConditionName,
    required String? conditionName,
    required int? initialInfoCount,
    required int? infoCount,
    required List<Map<String, dynamic>>? initialQuestions,
    final List<Map<String, dynamic>>? questions,
    required String? approvementId,
  }) async {
    try {
      if (!initialIsConditionAdded && isConditionAdded) {
        if (conditionName == 'Тест') {
          final result = await addFormApprovement(
            clubId: clubId,
            questions: questions!,
            apiService: apiService,
          );
          if (context.mounted && handleGraphQLErrors(context, result, fallbackMessage: 'Ошибка при добавлении теста')) return;
        
        } else if (conditionName == 'Запрос на вступление') {
          final result = await addMembersConfirmApprovement(
            clubId: clubId,
            requiredConfirmationNumber: infoCount!,
            apiService: apiService,
          );
          if (context.mounted && handleGraphQLErrors(context, result, fallbackMessage: 'Ошибка при добавлении подтвержения')) return;
        }
      
      } else if (initialIsConditionAdded && !isConditionAdded) {
        final result = await removeApprovement(
          approvementId: approvementId!,
          apiService: apiService,
        );
        if (context.mounted && handleGraphQLErrors(context, result, fallbackMessage: 'Ошибка при удалении условия')) return;
      
      } else if (initialIsConditionAdded && isConditionAdded) {
        final typeChanged = initialConditionName != conditionName;
        if (typeChanged) {
          final removed = await removeApprovement(
            approvementId: approvementId!,
            apiService: apiService,
          );
          if (context.mounted && handleGraphQLErrors(context, removed, fallbackMessage: 'Ошибка при удалении условия')) return;
          if (conditionName == 'Тест') {
            final result = await addFormApprovement(
              clubId: clubId,
              questions: questions!,
              apiService: apiService,
            );
            if (context.mounted && handleGraphQLErrors(context, result, fallbackMessage: 'Ошибка при добавлении теста')) return;
          } else if (conditionName == 'Запрос на вступление') {
            final result = await addMembersConfirmApprovement(
              clubId: clubId,
              requiredConfirmationNumber: infoCount!,
              apiService: apiService,
            );
            if (context.mounted && handleGraphQLErrors(context, result, fallbackMessage: 'Ошибка при добавлении подтвержения')) return;
          }
        } else {
          if (conditionName == 'Запрос на вступление' &&
              initialInfoCount != infoCount) {
            final result = await updateMembersConfirmApprovement(
              approvementId: approvementId!,
              requiredConfirmationNumber: infoCount!,
              apiService: apiService,
            );
            if (context.mounted && handleGraphQLErrors(context, result, fallbackMessage: 'Ошибка при обновлении подтвержения')) return;
          } else if (conditionName == 'Тест' &&
              !_areQuestionsEqual(initialQuestions, questions)) {
            final result = await updateFormApprovement(
              approvementId: approvementId!,
              questions: questions!,
              apiService: apiService,
            );
            if (context.mounted && handleGraphQLErrors(context, result, fallbackMessage: 'Ошибка при обновлении теста')) return;
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (context.mounted) {
        showErrorSnackbar(context, 'Произошла ошибка');
      }
    }
  }

  static bool _areQuestionsEqual(
      List<Map<String, dynamic>>? a, 
      List<Map<String, dynamic>>? b
  ) {
    if (a == null || b == null) return a == b;
    if (a.length != b.length) return false;

    const mapEq = DeepCollectionEquality();
    for (int i = 0; i < a.length; i++) {
      if (!mapEq.equals(a[i], b[i])) return false;
    }
    return true;
  }
}