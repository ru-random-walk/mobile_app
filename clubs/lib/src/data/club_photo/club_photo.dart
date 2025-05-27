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

  static const mutation = '''
    mutation uploadPhotoForClub(\$clubId: ID!, \$photo: PhotoInput!) {
      uploadPhotoForClub(clubId: \$clubId, photo: \$photo) {
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

  Future<Either<BaseError, RemoteImageInfo>> uploadPhotoForClub({
    required String clubId,
    required String base64Image,
  }) async {
    try {
      final variables = {
        'clubId': clubId,
        'photo': {
          'base64': base64Image,
        }
      };
      final result = await apiService.performPostRequest(mutation, variables);
      final data =
          result!['data']['uploadPhotoForClub'] as Map<String, dynamic>;
      final url = data['url'] as String;
      final photoVersion = data['photoVersion'] as int;
      return Right(
        RemoteImageInfo(
          url: url,
          version: photoVersion,
        ),
      );
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
