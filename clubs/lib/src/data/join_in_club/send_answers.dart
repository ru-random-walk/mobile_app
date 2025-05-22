part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> sendAnswers({
  required String answerId,
  required ClubApiService apiService,
}) async {
  const query = '''
    mutation SetAnswerStatusToSent(\$answerId: ID!) {
      setAnswerStatusToSent(answerId: \$answerId) {
        id
        status
      }
    }
  ''';

  final variables = {
    'answerId': answerId,
  };

  return await apiService.performPostRequest(query, variables);
}
