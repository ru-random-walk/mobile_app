part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> updateFormApprovement({
  required String approvementId,
  required List<Map<String, dynamic>> questions,
  required ClubApiService apiService,
}) async {
  const query = '''
    mutation updateFormApprovement(\$approvementId: ID!, \$form: FormInput!) {
      updateClubApprovementForm(
        approvementId: \$approvementId,
        form: \$form
      ) {
        id
        type
      }
    }
  ''';

  final variables = {
    'approvementId': approvementId,
    'form': {
      'questions': questions,
    },
  };

  return await apiService.performPostRequest(query, variables);
}
