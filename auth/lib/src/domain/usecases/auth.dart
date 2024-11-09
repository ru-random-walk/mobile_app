import 'package:auth/src/domain/entities/auth_type/base.dart';
import 'package:auth/src/domain/entities/auth_type/enum.dart';
import 'package:auth/src/domain/entities/token/exchange/request.dart';
import 'package:auth/src/domain/repositories/auth.dart';
import 'package:auth/src/domain/usecases/google_sign_in.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class AuthUseCase implements BaseUseCase<BaseError, void, AuthProvider> {
  final GetGoogleAccessTokenUseCase _getGoogleAccessTokenUseCase;
  final AuthRepository _authRepository;

  AuthUseCase(this._getGoogleAccessTokenUseCase, this._authRepository);

  @override
  Future<Either<BaseError, void>> call(AuthProvider type) async {
    final accessTokenResponse = switch (type) {
      AuthProvider.google => await _getGoogleAccessTokenUseCase(),
    };
    if (accessTokenResponse.isLeft) return accessTokenResponse;
    final authType = switch (type) {
      AuthProvider.google => AuthViaGoogle(accessTokenResponse.rightValue),
    };
    final response =
        await _authRepository.authVia(TokenExchangeRequestEntity(authType));
    /// TODO: impement storing access token in shared preferences
    return response;
  }
}
