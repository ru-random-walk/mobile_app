import 'package:auth/src/data/models/user/avatar_info.dart';
import 'package:auth/src/data/models/user/detailed_user.dart';
import 'package:auth/src/data/models/user/page_user.dart';
import 'package:auth/src/data/models/user/update_info.dart';
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

  @GET('$_prefix/users')
  Future<PageableUsersModel> getUsers(
    @Queries() PageQueryModel queryModel,
    @Query('ids') List<String> ids,
  );

  @GET('$_prefix/userinfo/{userId}/avatar')
  Future<UserAvatarInfoModel> getUserAvatar(
    @Path() String userId,
  );

  @PUT('$_prefix/userinfo/change')
  Future<DetailedUserModel> changeUserInfo(
    @Body() UpdateInfoUserModel updateInfoUserModel,
  );

  @PUT('$_prefix/userinfo/avatar/upload')
  @Headers({'Content-Type': 'multipart/form-data'})
  Future<UserAvatarInfoModel> changeUserAvatar(
    @Body() FormData file,
  );

  @POST('$_prefix/userinfo/logout')
  Future<HttpResponse> logout();

  @DELETE('$_prefix/userinfo/avatar/remove')
  Future<HttpResponse> removeAvatar();
}
