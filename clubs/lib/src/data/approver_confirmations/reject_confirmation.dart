part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> rejectConfirmation({
  required String confirmationId,
  required ClubApiService apiService,
}) async {
  const query = '''
    mutation rejectConfirmation(\$confirmationId: ID!) {
      rejectConfirmation(confirmationId: \$confirmationId) {
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