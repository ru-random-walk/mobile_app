part of "../clubs_api_service.dart";

Future<Map<String, dynamic>?> searchClubs({
  required String queryText,
  required int page,
  required int size,
  required ClubApiService apiService,
}) async {
  const query = '''
    query searchClubs(\$query: String!, \$pagination: PaginationInput) {
      searchClubs(query: \$query, pagination: \$pagination) {
        club {
          id
          name
          members{
            id
          }
          photoVersion
        }
        memberRole 
      }
    }
  ''';

  final variables = {
    'query': queryText,
    'pagination': {
      'page': page,
      'size': size,
    },
  };

  return await apiService.performPostRequest(query, variables);
}
