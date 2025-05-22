import 'dart:convert';
import 'dart:typed_data';

import 'package:clubs/src/data/club_photo/club_photo.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class ImageClubSenderRepostory {
  final _client = ClubPhotoDataSource();

  Future<Either<BaseError, String>> uploadPhotoForClub({
    required String clubId,
    required Uint8List imageBytes,
  }) {
    final base64 = base64Encode(imageBytes);
    return _client.uploadPhotoForClub(clubId: clubId, base64Image: base64);
  }
}
