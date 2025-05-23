import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:utils/utils.dart';

abstract interface class RemoteImageInfoRepository {
  Future<Either<BaseError, RemoteImageInfo>> uploadPhotoForObject({
    required String objectId,
    required Uint8List imageBytes,
  });

  Future<Either<BaseError, String>> getObjectPhotoUrl(String objectId);
}
