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
        id
        name
        members{
          id
        }
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

  final result = await apiService.performPostRequest(query, variables);
  return result!['data'];
}
