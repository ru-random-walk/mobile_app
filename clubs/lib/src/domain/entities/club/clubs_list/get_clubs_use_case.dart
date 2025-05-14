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
}
