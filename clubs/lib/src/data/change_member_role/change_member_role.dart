part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> changeMemberRole({
  required String clubId,
  required String memberId,
  required String role,
  required ClubApiService apiService,
}) async {
  const query = '''
    mutation ChangeMemberRole(\$clubId: ID!, \$memberId: ID!, \$role: MemberRole!) {
      changeMemberRole(clubId: \$clubId, memberId: \$memberId, role: \$role) {
        id
        role
      }
    }
  ''';

  final variables = {
    'clubId': clubId,
    'memberId': memberId,
    'role': role,    
  };

  final result = await apiService.performPostRequest(query, variables);
  return result!['data'];
}
