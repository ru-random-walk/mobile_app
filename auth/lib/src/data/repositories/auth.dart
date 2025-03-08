import 'dart:convert';

import 'package:auth/src/data/data_source/token.dart';
import 'package:auth/src/data/models/token/request/base.dart';
import 'package:auth/src/domain/entities/token/exchange/request.dart';
import 'package:auth/src/domain/entities/token/response.dart';
import 'package:auth/src/domain/repositories/auth.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class AuthRepositoryI implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryI(this._authDataSource);

  Future<String> get _authCredentials async {
    final credentials = EnvironmentVariables().authCredentials;
    if (credentials == null) {
      throw BaseError('Credentials is null', StackTrace.current);
    }
    final byteList = utf8.encode(credentials);
    final basicAuthCredentials = base64Encode(byteList);
    return basicAuthCredentials;
  }

  @override
  Future<Either<BaseError, TokenResponseEntity>> authVia(
    TokenExchangeRequestEntity entity,
  ) async {
    try {
      final model = TokenRequestModel.via(entity.authType);
      final basicAuthCredentials = await _authCredentials;
      final result =
          await _authDataSource.auth(model, 'Basic $basicAuthCredentials');
      final resultEntity = result.toEntity();
      return Right(resultEntity);
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }

  @override
  Future<Either<BaseError, TokenResponseEntity>> refreshToken(
      String refreshToken) async {
    try {
      final model = TokenRequestModel.refresh(refreshToken);
      final basicAuthCredentials = await _authCredentials;
      final result =
          await _authDataSource.auth(model, 'Basic $basicAuthCredentials');
      final resultEntity = result.toEntity();
      return Right(resultEntity);
    } catch (e, s) {
      /// TODO: разообраться с тем, что придет если refreshToken протух
      return Left(BaseError(e.toString(), s));
    }
  }
}
