part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> addMembersConfirmApprovement({
  required String clubId,
  required int requiredConfirmationNumber,
  required ClubApiService apiService,
}) async {
  const query = '''
    mutation addMembersConfirm(\$clubId: ID!, \$membersConfirm: MembersConfirmInput!) {
      addClubApprovementMembersConfirm(clubId: \$clubId, membersConfirm: \$membersConfirm) {
        id
        type
      }
    }
  ''';

  final variables = {
    'clubId': clubId,
    'membersConfirm': {
      'requiredConfirmationNumber': requiredConfirmationNumber,
      'approversToNotifyCount': requiredConfirmationNumber * 2,
    },
  };

  return await apiService.performPostRequest(query, variables);
}
