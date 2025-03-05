import 'dart:async';

import 'package:auth/src/data/data_source/user.dart';
import 'package:auth/src/data/repositories/user.dart';
import 'package:auth/src/domain/entities/user/detailed.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class GetProfileUseCase
    implements BaseUseCase<BaseError, DetailedUserEntity, void> {
  final UserRepository _userRepository;

  GetProfileUseCase._(this._userRepository);

  factory GetProfileUseCase() => GetProfileUseCase._(
        UserRepository(
          UsersDataSource(),
        ),
      );

  @override
  FutureOr<Either<BaseError, DetailedUserEntity>> call([_]) =>
      _userRepository.getMyProfileInfo();
}
