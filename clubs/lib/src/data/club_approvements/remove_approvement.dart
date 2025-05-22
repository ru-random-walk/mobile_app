part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> removeApprovement({
  required String approvementId,
  required ClubApiService apiService,
}) async {
  const query = '''
    mutation removeApprovement(\$approvementId: ID!) {
      removeClubApprovement(approvementId: \$approvementId)
    }
  ''';

  final variables = {
    'approvementId': approvementId,
  };

  return await apiService.performPostRequest(query, variables);
}
