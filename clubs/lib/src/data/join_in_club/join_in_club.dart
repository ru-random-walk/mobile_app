part of '../clubs_api_service.dart';

Future<Map<String, dynamic>?> tryJoinInClub({
  required String userId,
  required String clubId,
  required ClubApiService apiService,
}) async {
  const query = '''
    mutation TryJoinInClub(\$userId: ID!, \$clubId: ID!) {
      tryJoinInClub(userId: \$userId, clubId: \$clubId) {
        id
        role
      }
    }
  ''';

  final variables = {
    'userId': userId,
    'clubId': clubId,
  };

  return await apiService.performPostRequest(query, variables);
}
