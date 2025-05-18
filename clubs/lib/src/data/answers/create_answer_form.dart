part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> createAnswerForm({
  required String approvementId,
  required List<Map<String, List<int>>> questionAnswers,
  required ClubApiService apiService,
}) async {
  const query = '''
    mutation createApprovementAnswerForm(\$approvementId: ID!, \$formAnswer: FormAnswerInput!) {
      createApprovementAnswerForm(approvementId: \$approvementId, formAnswer: \$formAnswer) {
        id
        status
        data {
          ... on FormAnswerData {
            questionAnswers {
              optionNumbers
            }
          }
        }
      }
    }
  ''';

  final variables = {
    'approvementId': approvementId,
    'formAnswer': {
      'questionAnswers': questionAnswers,
    },  
  };

  return await apiService.performPostRequest(query, variables);
}
