import 'package:auth/src/data/data_source/user.dart';
import 'package:auth/src/data/mappers/detailed_user.dart';
import 'package:auth/src/domain/entities/user/detailed.dart';
import 'package:auth/src/domain/entities/user/user.dart';
import 'package:auth/src/domain/repositories/user.dart';
import 'package:core/src/error/base.dart';
import 'package:utils/src/either/either.dart';

class UserRepository implements UserRepositoryI {
  final UsersDataSource _usersDataSource;

  UserRepository(this._usersDataSource);

  @override
  Future<Either<BaseError, DetailedUserEntity>> getMyProfileInfo() async {
    try {
      final profile = await _usersDataSource.getMyProfileInfo();
      final profileEntity = profile.toDomain();
      return Right(profileEntity);
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }



  @override
  Future<Either<BaseError, List<UserEntity>>> getUsersInfo(List<String> ids) {
    // TODO: implement getUsersInfo
    throw UnimplementedError();
  }
}
