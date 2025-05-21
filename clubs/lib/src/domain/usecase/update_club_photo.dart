import 'dart:async';
import 'dart:typed_data';

import 'package:clubs/src/data/db/data_source/club_photo.dart';
import 'package:clubs/src/data/image/repository/sender.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class SetClubPhotoWhenCreatingArgs {
  final Uint8List imageBytes;
  final String clubId;

  SetClubPhotoWhenCreatingArgs({
    required this.imageBytes,
    required this.clubId,
  });
}

class SetClubPhotoWhenCreatingUseCase
    implements BaseUseCase<BaseError, void, SetClubPhotoWhenCreatingArgs> {
  final ImageClubSenderRepostory _sender;
  final ClubPhotoDatabaseInfoDataSource _dbInfo;
  final CacheImagesDataSource _cache;

  SetClubPhotoWhenCreatingUseCase({
    required ImageClubSenderRepostory sender,
    required ClubPhotoDatabaseInfoDataSource dbInfo,
    required CacheImagesDataSource cache,
  })  : _sender = sender,
        _dbInfo = dbInfo,
        _cache = cache;

  @override
  Future<Either<BaseError, void>> call(
    SetClubPhotoWhenCreatingArgs args,
  ) async {
    final bytes = args.imageBytes;
    final clubId = args.clubId;
    final res = await _sender.uploadPhotoForClub(
      clubId: clubId,
      imageBytes: bytes,
    );
    if (res.isLeft) return res;
    _dbInfo.addClubPhotoInfo(clubId, 1);
    _cache.saveImage(bytes, clubId);
    return Right(null);
  }
}
