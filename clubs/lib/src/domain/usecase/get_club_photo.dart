import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:clubs/src/data/club_photo/club_photo.dart';
import 'package:clubs/src/data/db/data_source/club_photo.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class EmptyPhotoError extends BaseError {
  EmptyPhotoError() : super('Empty photo', StackTrace.current);
}

class GetClubPhotoArgs {
  final String clubId;
  final int photoVersion;

  GetClubPhotoArgs({
    required this.clubId,
    required this.photoVersion,
  });
}

class GetClubPhotoUseCase
    implements BaseUseCase<BaseError, Uint8List, GetClubPhotoArgs> {
  final ClubPhotoDataSource clubPhotoDataSource;
  final ClubPhotoDatabaseInfoDataSource clubPhotoDatabaseInfoDataSource;
  final CacheImagesDataSource cacheImagesDataSource;

  GetClubPhotoUseCase({
    required this.clubPhotoDataSource,
    required this.clubPhotoDatabaseInfoDataSource,
    required this.cacheImagesDataSource,
  });

  @override
  Future<Either<BaseError, Uint8List>> call(GetClubPhotoArgs params) async {
    if (params.photoVersion == 0) {
      return Left(EmptyPhotoError());
    }
    final info =
        await clubPhotoDatabaseInfoDataSource.getClubPhotoInfo(params.clubId);
    log('Info for ${params.clubId} is $info');
    if (info == null || info.photoVersion < params.photoVersion) {
      final res = await _loadPhoto(params);
      return res;
    }
    final cachedImageBytes = await cacheImagesDataSource.getImageFromCache(
      params.clubId,
    );
    if (cachedImageBytes != null) {
      return Right(cachedImageBytes);
    } else {
      return _loadPhoto(params, updateDBInfo: false);
    }
  }

  Future<Either<BaseError, Uint8List>> _loadPhoto(
    GetClubPhotoArgs params, {
    bool updateDBInfo = true,
  }) async {
    final res = await clubPhotoDataSource.getClubPhotoUrl(params.clubId);
    switch (res) {
      case Left<BaseError, String> err:
        return Left(err.leftValue);
      case Right<BaseError, String> data:
        final url = data.rightValue;
        final imageBytes =
            await cacheImagesDataSource.downloadImage(url, params.clubId);
        if (updateDBInfo) {
          await clubPhotoDatabaseInfoDataSource.addClubPhotoInfo(
            params.clubId,
            params.photoVersion,
          );
        }
        return Right(imageBytes);
    }
  }
}
