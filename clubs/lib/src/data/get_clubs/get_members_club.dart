part of "../clubs_api_service.dart";

Future<List<Map<String, dynamic>>> getClubMembers({
  required String clubId,
  required int page,
  required int size,
  required ClubApiService apiService,
}) async {
  const query = '''
    query getClub(\$clubId: ID!, \$membersPagination: PaginationInput) {
      getClub(clubId: \$clubId, membersPagination: \$membersPagination) {
        members{
          id
          role
        }
      }
    }
  ''';

  final variables = {
    'clubId': clubId,
    'membersPagination': {
      'page': page,
      'size': size,
    },
  };

  final result = await apiService.performPostRequest(query, variables);
  if (result == null || result['data'] == null) {
    return [];
  }

  final members = result['data']['getClub']['members'] as List<dynamic>;
  return List<Map<String, dynamic>>.from(members);
}
