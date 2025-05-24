import 'package:auth/src/data/models/user/detailed_user.dart';
import 'package:auth/src/domain/entities/user/detailed.dart';

extension DetailedUserMapper on DetailedUserModel {
  DetailedUserEntity toDomain() {
    final int avatarVersionResult;
    if (avatarVersion == 0 && avatar != null) {
      avatarVersionResult = 1;
    } else {
      avatarVersionResult = avatarVersion;
    }
    return DetailedUserEntity(
      id: id,
      email: email,
      fullName: fullName,
      description: description,
      photoVersion: avatarVersionResult,
    );
  }
}
