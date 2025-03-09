import 'package:auth/src/data/data_source/user.dart';
import 'package:auth/src/data/mappers/detailed_user.dart';
import 'package:auth/src/data/mappers/pageable_users.dart';
import 'package:auth/src/domain/entities/user/detailed.dart';
import 'package:auth/src/domain/entities/user/pageable_users.dart';
import 'package:auth/src/domain/repositories/user.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

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
  Future<Either<BaseError, PageableUsersEntity>> getUsersInfo(
      PageQuery query, List<String> ids) async {
    try {
      final res = await _usersDataSource.getUsers(query.toModel(), ids);
      return Right(res.toDomain());
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }
}
