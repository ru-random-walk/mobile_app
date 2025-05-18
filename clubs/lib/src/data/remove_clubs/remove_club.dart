part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> removeClub({
  required String clubId,
  required ClubApiService apiService,
}) async {
  const query = '''
    mutation removeClubWithAllItsData(\$clubId: ID!) {
      removeClubWithAllItsData(clubId: \$clubId)
    }
  ''';

  final variables = {
    'clubId': clubId,
  };
 
  final result = await apiService.performPostRequest(query, variables);
  return result!['data'];
}
