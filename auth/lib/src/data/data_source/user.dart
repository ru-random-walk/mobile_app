import 'package:auth/src/data/models/user/detailed_user.dart';
import 'package:auth/src/data/models/user/page_user.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'user.g.dart';

@RestApi()
abstract class UsersDataSource {
  factory UsersDataSource() => _UsersDataSource(NetworkConfig.instance.dio);

  static const _prefix = '/auth';

  @GET('$_prefix/userinfo/me')
  Future<DetailedUserModel> getMyProfileInfo();

  @PUT('$_prefix/users')
  Future<PageableUsersModel> getUsers(
    @Queries() PageQueryModel queryModel,
    @Query('ids') List<String> ids,
  );
}
