import 'dart:async';
import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:utils/utils.dart';

class SetObjectPhotoArgs {
  final Uint8List imageBytes;
  final String objectId;

  SetObjectPhotoArgs({
    required this.imageBytes,
    required this.objectId,
  });
}

abstract class SetPhotoForObjectWithId<Arg extends SetObjectPhotoArgs>
    implements BaseUseCase<BaseError, void, Arg> {
  final LocalImageInfoRepository _dbInfo;
  final CacheImageRepository _cache;

  SetPhotoForObjectWithId({
    required LocalImageInfoRepository dbInfo,
    required CacheImageRepository cache,
  })  : _dbInfo = dbInfo,
        _cache = cache;

  Future<Either<BaseError, RemoteImageInfo>> uploadPhoto(Arg args);

  @override
  Future<Either<BaseError, void>> call(
    Arg args,
  ) async {
    final bytes = args.imageBytes;
    final objectId = args.objectId;
    final res = await uploadPhoto(args);
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
