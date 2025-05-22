part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> updateMembersConfirmApprovement({
  required String approvementId,
  required int requiredConfirmationNumber,
  required ClubApiService apiService,
}) async {
  const query = '''
    mutation updateMembersConfirmApprovement(\$approvementId: ID!, \$membersConfirm: MembersConfirmInput!) {
      updateClubApprovementMembersConfirm(
        approvementId: \$approvementId,
        membersConfirm: \$membersConfirm
      ) {
        id
        type
      }
    }
  ''';

  final variables = {
    'approvementId': approvementId,
    'membersConfirm': {
      'requiredConfirmationNumber': requiredConfirmationNumber,
      'approversToNotifyCount': requiredConfirmationNumber * 2,
    },
  };

  return await apiService.performPostRequest(query, variables);
}
