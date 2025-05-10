part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> createClubWithFormApprovement({
  required String name,
  String? description,
  required List<Map<String, dynamic>> questions,
  required ClubApiService apiService,
}) async {
  const query = '''
    mutation createClubWithFormApprovement(\$name: String!, \$description: String, \$form: FormInput!) {
      createClubWithFormApprovement(
        name: \$name,
        description: \$description,
        form: \$form
      ) {
        id
        name
        approvements {
          id
          type
        }
      }
    }
  ''';

  final variables = {
    'name': name,
    'description': description,
    'form': {
      'questions': questions,
    },
  };
  
  return await apiService.performPostRequest(query, variables);
}
