part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> getUserAnswers({
  required String userId,
  required int page,
  required int size,
  required ClubApiService apiService,
}) async {
  const query = '''
    query getUserAnswers(\$userId: ID!, \$pagination: PaginationInput) {
      getUserAnswers(userId: \$userId, pagination: \$pagination) {
        id
        status
        approvement {
          id
          club {
            id
          }
        }
        data {
          ... on FormAnswerData {
            questionAnswers {
              optionNumbers
            }
          }
        }
      }
    }
  ''';

  final variables = {
    'userId': userId,
    'pagination': {
      'page': page,
      'size': size,
    },
  };

  return await apiService.performPostRequest(query, variables);
}
