part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> createApprovementAnswerMembersConfirm({
  required String approvementId,
  required ClubApiService apiService,
}) async {
  const query = '''
    mutation CreateApprovementAnswerMembersConfirm(\$approvementId: ID!) {
      createApprovementAnswerMembersConfirm(approvementId: \$approvementId) {
        id
        status
      }
    }
  ''';

  final variables = {
    'approvementId': approvementId,
  };

  return await apiService.performPostRequest(query, variables);
}
