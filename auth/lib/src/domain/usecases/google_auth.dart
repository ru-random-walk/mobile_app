import 'package:auth/src/domain/entities/auth_type/base.dart';
import 'package:auth/src/domain/entities/auth_type/enum.dart';
import 'package:auth/src/domain/repositories/auth.dart';
import 'package:auth/src/domain/usecases/google_sign_in.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class GoogleAuthUseCase implements BaseUseCase<BaseError, void, AuthProvider> {
  final GetGoogleAccessTokenUseCase _getGoogleAccessTokenUseCase;
  final AuthRepository _authRepository;
  final TokenStorage _tokenStorage;

  GoogleAuthUseCase(
    this._getGoogleAccessTokenUseCase,
    this._authRepository,
    this._tokenStorage,
  );

  @override
  Future<Either<BaseError, void>> call(AuthProvider type) async {
    final accessTokenResponse = switch (type) {
      AuthProvider.google => await _getGoogleAccessTokenUseCase(),
    };
    if (accessTokenResponse.isLeft) return accessTokenResponse;
    final authType = switch (type) {
      AuthProvider.google => AuthViaGoogle(accessTokenResponse.rightValue),
    };
    final response = await _authRepository.authVia(authType);
    if (response.isRight) {
      await _tokenStorage.updateData(response.rightValue);
    }
    return response;
  }
}
