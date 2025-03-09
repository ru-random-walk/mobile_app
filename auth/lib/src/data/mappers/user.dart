import 'package:auth/auth.dart';
import 'package:auth/src/data/models/user/user.dart';

extension UserMapper on UserModel {
  UserEntity toDomain() => UserEntity(
        id: id,
        fullName: fullName,
        avatar: avatar,
      );
}
