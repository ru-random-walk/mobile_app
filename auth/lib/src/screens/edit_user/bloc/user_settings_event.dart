part of 'user_settings_bloc.dart';

@immutable
sealed class UserSettingsEvent {
  const UserSettingsEvent();
}

class UpdateUserSettings extends UserSettingsEvent {
  final UpdateUserInfoEntity? updateInfo;
  final UpdateUserAvatar? photo;

  const UpdateUserSettings({
    required this.updateInfo,
    required this.photo,
  });
}
