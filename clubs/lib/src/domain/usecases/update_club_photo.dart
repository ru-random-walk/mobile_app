import 'package:clubs/src/data/image/repository/sender.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class UpdateClubPhotoUseCase extends SetPhotoForObjectWithId {
  final RemoteImageClubRepostory sender;

  UpdateClubPhotoUseCase({
    required super.dbInfo,
    required super.cache,
    required this.sender,
  });

  @override
  Future<Either<BaseError, RemoteImageInfo>> uploadPhoto(
          SetObjectPhotoArgs args) =>
      sender.uploadPhotoForObject(
        objectId: args.objectId,
        imageBytes: args.imageBytes,
      );
}
