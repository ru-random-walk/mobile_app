import 'package:clubs/src/data/clubs_api_service.dart';

class GetClubsUseCase {
  final String userId;
  
  final ClubApiService apiService;

  GetClubsUseCase({
    required this.userId,

    required this.apiService,
  });

  Future<List<Map<String, dynamic>>> getClubs() async {
    final response = await getUserClubs(userId: userId, apiService: apiService);
    final raw = response?['getUserClubsWithRole'] ?? [];
    return List<Map<String, dynamic>>.from(raw);
  }

  Future<List<Map<String, dynamic>>> getSearchedClubs({
    required final String query,
    required final int page,
    required final int size,
  }) async {
    final response = await searchClubs(
    queryText: query, 
      page: page, 
      size: size,
      apiService: apiService,
    );
    final raw = response?['searchClubs'] ?? [];
    return List<Map<String, dynamic>>.from(raw);
  }
}
