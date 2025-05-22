part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> getApproverWaitingConfirmations({
  required String approverId,
  required int page,
  required int size,
  required ClubApiService apiService,
}) async {
  const query = '''
    query getApproverWaitingConfirmations(\$approverId: ID!, \$pagination: PaginationInput) {
      getApproverWaitingConfirmations(approverId: \$approverId, pagination: \$pagination) {
        id
        userId
        status
        answer {
          id
          status
          approvement{
            club{
              id
            }
          }
        }
      }
    }
  ''';

  final variables = {
    'approverId': approverId,
    'pagination': {
      'page': page,
      'size': size,
    },
  };

  return await apiService.performPostRequest(query, variables);
}
