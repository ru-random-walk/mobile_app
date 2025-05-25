import 'package:auth/src/data/models/user/detailed_user.dart';
import 'package:auth/src/domain/entities/user/detailed.dart';

extension DetailedUserMapper on DetailedUserModel {
  DetailedUserEntity toDomain() {
    return DetailedUserEntity(
      id: id,
      email: email,
      fullName: fullName,
      description: description,
      photoVersion: avatarVersion,
      avatar: avatar,
    );
  }
}
