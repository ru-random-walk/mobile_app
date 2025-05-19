part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> removeMemberFromClub({
  required String clubId,
  required String memberId,
  required ClubApiService apiService,
}) async {
  const query = '''
  mutation RemoveMemberFromClub(\$clubId: ID!, \$memberId: ID!) {
    removeMemberFromClub(clubId: \$clubId, memberId: \$memberId)
  }
  ''';

  final variables = {
    'clubId': clubId,
    'memberId': memberId,
  };

  return await apiService.performPostRequest(query, variables);
}
