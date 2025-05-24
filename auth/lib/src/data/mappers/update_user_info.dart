import 'package:auth/src/data/models/user/update_info.dart';
import 'package:auth/src/domain/entities/user/update_user_info.dart';

extension UpdateUserInfoMapper on UpdateUserInfoEntity {
  UpdateInfoUserModel toModel() => UpdateInfoUserModel(
        fullName: fullName,
        aboutMe: aboutMe,
      );
}
