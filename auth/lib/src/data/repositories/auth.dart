import 'dart:convert';

import 'package:auth/src/data/data_source/token.dart';
import 'package:auth/src/data/models/token/request/base.dart';
import 'package:auth/src/domain/entities/token/exchange/request.dart';
import 'package:auth/src/domain/entities/token/response.dart';
import 'package:auth/src/domain/repositories/auth.dart';
import 'package:core/core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:utils/utils.dart';

class AuthRepositoryI implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryI(this._authDataSource);

  @override
  Future<Either<BaseError, TokenResponseEntity>> authVia(
    TokenExchangeRequestEntity entity,
  ) async {
    try {
      final model = TokenRequestModel.via(entity.authType);
      await dotenv.load(fileName: 'auth.env');
      final credentials = dotenv.env['USERNAME_AND_PASSWORD'];
      if (credentials == null) {
        return Left(BaseError('Credentials is null', StackTrace.current));
      }
      final byteList = utf8.encode(credentials);
      final basicAuthCredentials = base64Encode(byteList);
      final result =
          await _authDataSource.auth(model, 'Basic $basicAuthCredentials');
      final resultEntity = result.toEntity();
      return Right(resultEntity);
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }

  @override
  Future<Either<BaseError, TokenResponseEntity>> refreshToken() {
    throw UnimplementedError();
  }
}
