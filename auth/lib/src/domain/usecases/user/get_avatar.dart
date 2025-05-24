import 'dart:developer';
import 'dart:typed_data';

import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:utils/src/either/either.dart';

class GetUserAvatarUseCase extends GetPhotoForObjectWithId<UserEntity> {
  GetUserAvatarUseCase({
    required super.getImageRepository,
    required super.dbInfo,
    required super.cache,
  });

  @override
  Future<Either<BaseError, Uint8List>> call(UserEntity params) async {
    if (params.photoVersion == 0 && params.avatar == null) {
      return Left(EmptyPhotoError());
    }
    final info = await dbInfo.getImageInfo(params.objectId);
    log('Info for avatar ${params.objectId} is version ${info?.version}');
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

  @override
  Future<Either<BaseError, String>> getUrlForImageDownloading(
    UserEntity params,
  ) async {
    final avatarUrl = params.avatar;
    if (params.photoVersion == 0 && avatarUrl != null) {
      return Right<BaseError, String>(avatarUrl);
    } else {
      return await super.getUrlForImageDownloading(params);
    }
  }
}
