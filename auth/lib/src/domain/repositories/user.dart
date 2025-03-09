import 'package:auth/src/domain/entities/user/detailed.dart';
import 'package:auth/src/domain/entities/user/pageable_users.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

abstract interface class UserRepositoryI {
  Future<Either<BaseError, DetailedUserEntity>> getMyProfileInfo();

  Future<Either<BaseError, PageableUsersEntity>> getUsersInfo(
    PageQuery query,
    List<String> ids,
  );
}
