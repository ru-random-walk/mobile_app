part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> addFormApprovement({
  required String clubId,
  required List<Map<String, dynamic>> questions,
  required ClubApiService apiService,
}) async {
  const query = '''
    mutation addFormApprovement(\$clubId: ID!, \$form: FormInput!) {
      addClubApprovementForm(clubId: \$clubId, form: \$form) {
        id
        type
      }
    }
  ''';

  final variables = {
    'clubId': clubId,
    'form': {
      'questions': questions,
    },
  };

  return await apiService.performPostRequest(query, variables);
}
