import 'dart:async';

import 'package:auth/src/domain/repositories/auth.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class SendEmailOTPUseCase implements BaseUseCase<BaseError, void, String> {
  final AuthRepository _authRepository;

  SendEmailOTPUseCase(this._authRepository);

  @override
  FutureOr<Either<BaseError, void>> call(String email) =>
      _authRepository.sendEmailOTP(email);
}
