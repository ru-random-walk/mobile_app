import 'package:auth/auth.dart';

extension UserMapper on UserModel {
  UserEntity toDomain() {
    final int avatarVersionResult;
    if (avatarVersion == 0 && avatar != null) {
      avatarVersionResult = 1;
    } else {
      avatarVersionResult = avatarVersion;
    }
    return UserEntity(
      id: id,
      fullName: fullName,
      photoVersion: avatarVersionResult,
      description: description,
    );
  }
}
