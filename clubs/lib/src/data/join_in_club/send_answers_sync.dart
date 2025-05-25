part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> sendAnswersSync({
  required String answerId,
  required ClubApiService apiService,
}) async {
  const query = '''
    mutation setAnswerStatusToSentSync(\$answerId: ID!) {
      setAnswerStatusToSentSync(answerId: \$answerId) {
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
