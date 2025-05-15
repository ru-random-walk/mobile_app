part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> getUserClubs({
  required String userId,
  required ClubApiService apiService,
}) async {
  const query = '''
    query getUserClubsWithRole(\$userId: ID!) {
      getUserClubsWithRole(userId: \$userId) {
        club {
          id
          name
          members{
            id
          }
        }
        userRole
      }
    }
  ''';

  final variables = {
    'userId': userId,
  };

  final result = await apiService.performPostRequest(query, variables);
  return result!['data'];
}
