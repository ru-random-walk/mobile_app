import 'dart:async';

import 'package:auth/src/domain/entities/auth_type/base.dart';
import 'package:auth/src/domain/repositories/auth.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class EmailOTPAuthUseCase
    implements BaseUseCase<BaseError, void, EmailOTPAuthType> {
  final AuthRepository _authRepository;
  final TokenStorage _tokenStorage;

  EmailOTPAuthUseCase(this._authRepository, this._tokenStorage);

  @override
  FutureOr<Either<BaseError, void>> call(EmailOTPAuthType authType) async {
    final response = await _authRepository.authVia(authType);
    if (response.isRight) {
      await _tokenStorage.updateData(response.rightValue);
    }
    return response;
  }
}
