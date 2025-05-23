import 'dart:async';
import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:core/src/domain/enitites/image_info.dart';
import 'package:core/src/domain/repository/cache_image.dart';
import 'package:core/src/domain/repository/image_info.dart';
import 'package:core/src/domain/repository/image_sender.dart';
import 'package:utils/utils.dart';

class SetObjectPhotoArgs {
  final Uint8List imageBytes;
  final String objectId;

  SetObjectPhotoArgs({
    required this.imageBytes,
    required this.objectId,
  });
}

class SetPhotoForObjectWithId
    implements BaseUseCase<BaseError, void, SetObjectPhotoArgs> {
  final RemoteImageInfoRepository _sender;
  final LocalImageInfoRepository _dbInfo;
  final CacheImageRepository _cache;

  SetPhotoForObjectWithId({
    required RemoteImageInfoRepository sender,
    required LocalImageInfoRepository dbInfo,
    required CacheImageRepository cache,
  })  : _sender = sender,
        _dbInfo = dbInfo,
        _cache = cache;

  @override
  Future<Either<BaseError, void>> call(
    SetObjectPhotoArgs args,
  ) async {
    final bytes = args.imageBytes;
    final objectId = args.objectId;
    final res = await _sender.uploadPhotoForObject(
      objectId: objectId,
      imageBytes: bytes,
    );
    if (res.isLeft) return res;
    final remoteImageInfo = res.rightValue;
    final newLocalImageInfo = LocalImageInfo(
      objectId: objectId,
      version: remoteImageInfo.version,
    );
    _dbInfo.saveImageInfo(newLocalImageInfo);
    _cache.saveImage(bytes, objectId);
    return Right(null);
  }
}
