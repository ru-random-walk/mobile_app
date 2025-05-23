import 'package:auth/src/data/models/user/detailed_user.dart';
import 'package:auth/src/domain/entities/user/detailed.dart';

extension DetailedUserMapper on DetailedUserModel {
  DetailedUserEntity toDomain() => DetailedUserEntity(
        id: id,
        email: email,
        avatar: avatar,
        fullName: fullName,
        photoVersion: 1,
      );
}
