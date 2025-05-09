part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> createClubWithConfirmApprovement({
  required String name,
  String? description,
  required int infoCount,
  required ClubApiService apiService,
}) async {
  const query = '''
    mutation createMyClubWithMembersConfirmApprovement(\$name: String!, \$description: String, \$membersConfirm: MembersConfirmInput!) {
      createClubWithMembersConfirmApprovement(
        name: \$name,
        description: \$description,
        membersConfirm: \$membersConfirm
      ) {
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
    'membersConfirm': {
      'requiredConfirmationNumber': infoCount,
      'approversToNotifyCount': infoCount * 2,
      },
  };

  return await apiService.performPostRequest(query, variables);
}
