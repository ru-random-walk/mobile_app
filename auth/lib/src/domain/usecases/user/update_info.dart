import 'dart:async';

import 'package:auth/auth.dart';
import 'package:auth/src/domain/entities/user/update_user_info.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class UpdateUserInfoUseCase
    implements
        BaseUseCase<BaseError, DetailedUserEntity, UpdateUserInfoEntity> {
  final UserRepository _userRepository;

  UpdateUserInfoUseCase(this._userRepository);

  @override
  FutureOr<Either<BaseError, DetailedUserEntity>> call(
    UpdateUserInfoEntity params,
  ) =>
      _userRepository.updateUserInfo(params);
}
