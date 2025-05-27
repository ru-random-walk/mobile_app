import 'package:auth/src/data/data_source/remote/user.dart';
import 'package:auth/src/data/mappers/detailed_user.dart';
import 'package:auth/src/data/mappers/pageable_users.dart';
import 'package:auth/src/data/mappers/update_user_info.dart';
import 'package:auth/src/domain/entities/user/detailed.dart';
import 'package:auth/src/domain/entities/user/pageable_users.dart';
import 'package:auth/src/domain/entities/user/update_user_info.dart';
import 'package:auth/src/domain/repositories/user.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:utils/utils.dart';

class UserRepository implements UserRepositoryI, RemoteImageInfoRepository {
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

  @override
  Future<Either<BaseError, String>> getObjectPhotoUrl(String objectId) async {
    try {
      final res = await _usersDataSource.getUserAvatar(objectId);
      final url = res.avatarUrl;
      if (url == null) return Left(BaseError('Avatar not found', null));
      return Right(url);
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }

  Future<Either<BaseError, RemoteImageInfo>> uploadPhotoForObject({
    required String objectId,
    required XFile xfile,
  }) async {
    try {
      final mimeType = lookupMimeType(xfile.path)?.split('/') ?? ['image', 'jpeg'];
      final file = FormData.fromMap(
        {
          'file': MultipartFile.fromBytes(
            await xfile.readAsBytes(),
            filename: xfile.name,
            contentType: DioMediaType(mimeType[0], mimeType[1]),
          ),
        },
      );
      final res = await _usersDataSource.changeUserAvatar(file);
      final avatarUrl = res.avatarUrl;
      if (avatarUrl == null) return Left(BaseError('Avatar not found', null));
      final newImageInfo = RemoteImageInfo(
        url: avatarUrl,
        version: res.avatarVersion,
      );
      return Right(newImageInfo);
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }

  @override
  Future<Either<BaseError, DetailedUserEntity>> updateUserInfo(
    UpdateUserInfoEntity updateUser,
  ) async {
    try {
      final res = await _usersDataSource.changeUserInfo(
        updateUser.toModel(),
      );
      return Right(res.toDomain());
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }

  @override
  Future<Either<BaseError, void>> logout() async {
    try {
      final res = await _usersDataSource.logout();
      if (res.response.statusCode == 200) {
        return Right(null);
      } else {
        return Left(BaseError(res.response.data, StackTrace.current));
      }
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }
}
