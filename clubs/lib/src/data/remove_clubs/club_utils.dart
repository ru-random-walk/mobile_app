import 'package:clubs/src/data/clubs_api_service.dart';

Future<void> deleteAllUserClubs({
  required String userId,
  required ClubApiService apiService,
}) async {
  final result = await getUserClubs(userId: userId, apiService: apiService);

  if (result != null && result['getUserClubsWithRole'] != null) {
    final clubs = result['getUserClubsWithRole'] as List;

    final clubIds = clubs.map((clubData) {
      final club = clubData['club'];
      return club['id'] as String;
    }).toList();

    for (final clubId in clubIds) {
      await removeClub(clubId: clubId, apiService: apiService);
    }
  }
}
