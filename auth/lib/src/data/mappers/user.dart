import 'package:auth/auth.dart';

extension UserMapper on UserModel {
  UserEntity toDomain() {
    return UserEntity(
      id: id,
      fullName: fullName,
      photoVersion: avatarVersion,
      description: description,
      avatar: avatar,
    );
  }
}
