import 'package:auth/src/domain/entities/token/exchange/request.dart';
import 'package:auth/src/domain/entities/token/response.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

abstract interface class AuthRepository {
  Future<Either<BaseError, TokenResponseEntity>> authVia(
    TokenExchangeRequestEntity requestExchange,
  );

  Future<Either<BaseError, TokenResponseEntity>> refreshToken();
}
