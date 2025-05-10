part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> createClub({
  required String name,
  String? description,
  required ClubApiService apiService,
}) async {
  const query = '''
    mutation createMyClub(\$name: String!, \$description: String) {
      createClub(name: \$name, description: \$description) {
        id
        name
        members {
          id
          role
        }
      }
    }
  ''';

  final variables = {
    'name': name,
    'description': description,
  };

  return await apiService.performPostRequest(query, variables);
}

