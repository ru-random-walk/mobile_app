import 'package:auth/auth.dart';

extension UserMapper on UserModel {
  UserEntity toDomain() => UserEntity(
        id: id,
        fullName: fullName,
        avatar: avatar,
      );
}
