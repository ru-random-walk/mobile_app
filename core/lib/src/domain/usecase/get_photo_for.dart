import 'dart:developer';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
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

class GetPhotoForObjectWithId<Param extends GetObjectPhotoArgs>
    implements BaseUseCase<BaseError, Uint8List, Param> {
  @protected
  final RemoteImageInfoRepository getImageRepository;

  @protected
  final LocalImageInfoRepository dbInfo;

  @protected
  final CacheImageRepository cache;

  GetPhotoForObjectWithId({
    required this.getImageRepository,
    required this.dbInfo,
    required this.cache,
  });

  @override
  Future<Either<BaseError, Uint8List>> call(Param params) async {
    if (params.photoVersion == 0) {
      return Left(EmptyPhotoError());
    }
    final info = await dbInfo.getImageInfo(params.objectId);
    log('Info for ${params.objectId} is $info');
    if (info == null || info.version < params.photoVersion) {
      final res = await loadPhoto(params);
      return res;
    }
    final cachedImageBytes = await cache.getImageFromCache(
      params.objectId,
    );
    if (cachedImageBytes != null) {
      return Right(cachedImageBytes);
    } else {
      return loadPhoto(params, updateDBInfo: false);
    }
  }

  @visibleForOverriding
  Future<Either<BaseError, String>> getUrlForImageDownloading(
    Param params,
  ) =>
      getImageRepository.getObjectPhotoUrl(params.objectId);

  @protected
  Future<Either<BaseError, Uint8List>> loadPhoto(
    Param params, {
    bool updateDBInfo = true,
  }) async {
    final res = await getUrlForImageDownloading(params);
    switch (res) {
      case Left<BaseError, String> err:
        return Left(err.leftValue);
      case Right<BaseError, String> data:
        final url = data.rightValue;
        final imageBytes = await cache.downloadImage(url, params.objectId);
        if (updateDBInfo) {
          await dbInfo.saveImageInfo(
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
