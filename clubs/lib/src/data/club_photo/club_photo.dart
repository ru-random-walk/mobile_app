import 'package:clubs/src/data/clubs_api_service.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class ClubPhotoDataSource {
  final apiService = ClubApiService();

  static const query = '''
    query getClubPhoto(\$clubId: ID!) {
      getClubPhoto(clubId: \$clubId) {
        url
      }
    }
  ''';

  Future<Either<BaseError, String>> getClubPhotoUrl(String clubId) async {
    try {
      final variables = {'clubId': clubId};
      final result = await apiService.performPostRequest(query, variables);
      final url = result!['data']['getClubPhoto']['url'] as String;
      return Right(url);
    } catch (e, stackTrace) {
      return Left(
        BaseError(
          e.toString(),
          stackTrace,
        ),
      );
    }
  }
}
