part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> addMemberInClub({
  required String clubId,
  required String memberId,
  required ClubApiService apiService,
}) async {
  const query = '''
    mutation addMemberInClub(\$clubId: ID!, \$memberId: ID!) {
      addMemberInClub(clubId: \$clubId, memberId: \$memberId) {
        id
        role
      }
    }
  ''';

  final variables = {
    'clubId': clubId,
    'memberId': memberId,    
  };

  final result = await apiService.performPostRequest(query, variables);
  return result!['data'];
}
