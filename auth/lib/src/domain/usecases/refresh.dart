import 'package:auth/src/data/data_source/token.dart';
import 'package:auth/src/data/repositories/auth.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:utils/utils.dart';

class AuthWithRefreshTokenUseCase {
  final _authRepository = AuthRepositoryI(
    AuthDataSource(
      Dio(BaseOptions(baseUrl: NetworkConfig.instance.baseUrl)),
    ),
  );
  final _tokenStorage = TokenStorage();

  AuthWithRefreshTokenUseCase();

  Future<Either<BaseError, void>> call() async {
    final refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken == null) {
      return Left(
        BaseError(
          'Refresh token is null',
          StackTrace.current,
        ),
      );
    }
    final res = await _authRepository.refreshToken(refreshToken);
    return await res.fold(
      Left.new,
      (data) async{
        await _tokenStorage.updateData(data);
        return Right(null);
      },
    );
  }
}
