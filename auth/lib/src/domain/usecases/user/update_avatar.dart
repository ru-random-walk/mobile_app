import 'package:auth/src/data/repositories/user.dart';
import 'package:auth/src/domain/entities/user/update_avatar.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class UpdateAvatarUseCase extends SetPhotoForObjectWithId<UpdateUserAvatar> {
  final UserRepository _userRepository;

  UpdateAvatarUseCase({
    required UserRepository userRepository,
    required super.dbInfo,
    required super.cache,
  }) : _userRepository = userRepository;

  @override
  Future<Either<BaseError, RemoteImageInfo>> uploadPhoto(
          UpdateUserAvatar args) =>
      _userRepository.uploadPhotoForObject(
        objectId: args.objectId,
        xfile: args.file,
      );
}
