part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> getApprovementInfo({
  required String clubId,
  required ClubApiService apiService,
}) async {
  const query = '''
    query getClub(\$clubId: ID!) {
      getClub(clubId: \$clubId) {
        approvements{
          id
          type
          data {
            __typename
            ... on MembersConfirmApprovementData {
              requiredConfirmationNumber
              approversToNotifyCount
            }
            ... on FormApprovementData {
              questions {
                text
                answerOptions
                answerType
                correctOptionNumbers
              }
            }
          }
        }
      }
    }
  ''';

  final variables = {
    'clubId': clubId,
  };

  return await apiService.performPostRequest(query, variables);
}
