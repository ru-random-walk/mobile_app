part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> getClubInfo({
  required String clubId,
  required ClubApiService apiService,
}) async {
  const query = '''
    query getClub(\$clubId: ID!) {
      getClub(clubId: \$clubId) {
        id
        name
        description
        approvements{
          id
          type
        }
        photoVersion
      }
    }
  ''';

  final variables = {
    'clubId': clubId,
  };

  return await apiService.performPostRequest(query, variables);
}
