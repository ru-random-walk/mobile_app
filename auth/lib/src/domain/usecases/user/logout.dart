import 'dart:async';

import 'package:auth/src/data/repositories/user.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class LogoutUseCase implements BaseUseCase<BaseError, void, void> {
  final UserRepository userRepository;
  final tokenStorage = TokenStorage();

  LogoutUseCase(this.userRepository);

  @override
  Future<Either<BaseError, void>> call([_]) async {
    try {
      userRepository.logout();
      await tokenStorage.clear();
      return Right(null);
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }
}
