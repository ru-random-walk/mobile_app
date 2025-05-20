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
          photoVersion
        }
        userRole 
      }
    }
  ''';

  final variables = {
    'userId': userId,
  };

  return await apiService.performPostRequest(query, variables);
}
