import 'dart:convert';
import 'dart:typed_data';

import 'package:auth/src/data/data_source/remote/user.dart';
import 'package:auth/src/data/mappers/detailed_user.dart';
import 'package:auth/src/data/mappers/pageable_users.dart';
import 'package:auth/src/data/mappers/update_user_info.dart';
import 'package:auth/src/data/models/user/upload_image.dart';
import 'package:auth/src/domain/entities/user/detailed.dart';
import 'package:auth/src/domain/entities/user/pageable_users.dart';
import 'package:auth/src/domain/entities/user/update_user_info.dart';
import 'package:auth/src/domain/repositories/user.dart';
import 'package:core/core.dart';
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

  @override
  Future<Either<BaseError, RemoteImageInfo>> uploadPhotoForObject({
    required String objectId,
    required Uint8List imageBytes,
  }) async {
    try {
      final base64 = base64Encode(imageBytes);
      final res = await _usersDataSource.changeUserAvatar(
        UploadUserAvatarModel(file: base64),
      );
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
}
