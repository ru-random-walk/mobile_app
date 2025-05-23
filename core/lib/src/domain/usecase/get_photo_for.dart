import 'dart:developer';
import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:utils/utils.dart';

class EmptyPhotoError extends BaseError {
  EmptyPhotoError() : super('Empty photo', StackTrace.current);
}

class GetObjectPhotoArgs {
  final String objectId;
  final int photoVersion;

  GetObjectPhotoArgs({
    required this.objectId,
    required this.photoVersion,
  });
}

class GetPhotoForObjectWithId
    implements BaseUseCase<BaseError, Uint8List, GetObjectPhotoArgs> {
  final RemoteImageInfoRepository _getImageRepository;
  final LocalImageInfoRepository _dbInfo;
  final CacheImageRepository _cache;

  GetPhotoForObjectWithId({
    required RemoteImageInfoRepository getImageRepository,
    required LocalImageInfoRepository dbInfo,
    required CacheImageRepository cache,
  })  : _getImageRepository = getImageRepository,
        _dbInfo = dbInfo,
        _cache = cache;

  @override
  Future<Either<BaseError, Uint8List>> call(GetObjectPhotoArgs params) async {
    if (params.photoVersion == 0) {
      return Left(EmptyPhotoError());
    }
    final info = await _dbInfo.getImageInfo(params.objectId);
    log('Info for ${params.objectId} is $info');
    if (info == null || info.version < params.photoVersion) {
      final res = await _loadPhoto(params);
      return res;
    }
    final cachedImageBytes = await _cache.getImageFromCache(
      params.objectId,
    );
    if (cachedImageBytes != null) {
      return Right(cachedImageBytes);
    } else {
      return _loadPhoto(params, updateDBInfo: false);
    }
  }

  Future<Either<BaseError, Uint8List>> _loadPhoto(
    GetObjectPhotoArgs params, {
    bool updateDBInfo = true,
  }) async {
    final res = await _getImageRepository.getObjectPhotoUrl(params.objectId);
    switch (res) {
      case Left<BaseError, String> err:
        return Left(err.leftValue);
      case Right<BaseError, String> data:
        final url = data.rightValue;
        final imageBytes = await _cache.downloadImage(url, params.objectId);
        if (updateDBInfo) {
          await _dbInfo.saveImageInfo(
            LocalImageInfo(
              objectId: params.objectId,
              version: params.photoVersion,
            ),
          );
        }
        return Right(imageBytes);
    }
  }
}
