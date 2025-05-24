import 'package:auth/src/domain/entities/auth_type/base.dart';
import 'package:auth/src/domain/entities/token/response.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

abstract interface class AuthRepository {
  Future<Either<BaseError, TokenResponseEntity>> authVia(
    AuthType authType,
  );

  Future<Either<BaseError, TokenResponseEntity>> refreshToken(String refreshToken);

  Future<Either<BaseError, void>> sendEmailOTP(String email);
}
