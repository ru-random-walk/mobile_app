import 'dart:convert';
import 'dart:typed_data';

import 'package:clubs/src/data/club_photo/club_photo.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class RemoteImageClubRepostory implements RemoteImageInfoRepository {
  final _client = ClubPhotoDataSource();

  Future<Either<BaseError, RemoteImageInfo>> uploadPhotoForObject({
    required String objectId,
    required Uint8List imageBytes,
  }) async {
    final base64 = base64Encode(imageBytes);
    final res = await _client.uploadPhotoForClub(
      clubId: objectId,
      base64Image: base64,
    );
    return res;
  }

  @override
  Future<Either<BaseError, String>> getObjectPhotoUrl(String objectId) =>
      _client.getClubPhotoUrl(objectId);
}
