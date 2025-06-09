part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> updateAnswerForm({
  required String answerId,
  required List<Map<String, List<int>>> questionAnswers,
  required ClubApiService apiService,
}) async {
  const query = '''
    mutation updateAnswerForm(\$answerId: ID!, \$formAnswer: FormAnswerInput!) {
      updateAnswerForm(answerId: \$answerId, formAnswer: \$formAnswer) {
        id
        status
        approvement {
          id
          club {
            id
          }
        }
      }
    }
  ''';

  final variables = {
    'answerId': answerId,
    'formAnswer': {
      'questionAnswers': questionAnswers,
    },  
  };

  return await apiService.performPostRequest(query, variables);
}
