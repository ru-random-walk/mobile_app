part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> approveConfirmation({
  required String confirmationId,
  required ClubApiService apiService,
}) async {
  const query = '''
    mutation ApproveConfirmation(\$confirmationId: ID!) {
      approveConfirmation(confirmationId: \$confirmationId) {
        id
        status
        userId
      }
    }
  ''';

  final variables = {
    'confirmationId': confirmationId,
  };

  return await apiService.performPostRequest(query, variables);
}