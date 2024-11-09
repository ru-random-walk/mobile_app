import 'package:auth/src/domain/repositories/google_sign_in.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class GetGoogleAccessTokenUseCase
    implements BaseUseCase<BaseError, String, void> {
  final GoogleSignInRepository _googleSignInRepository;

  GetGoogleAccessTokenUseCase(this._googleSignInRepository);

  @override
  Future<Either<BaseError, String>> call([_]) async {
    try {
      final accessToken = await _googleSignInRepository.getGoogleAccessToken();
      return Right(accessToken);
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }
}
