part of 'user_settings_bloc.dart';

@immutable
sealed class UserSettingsState {}

final class UserSettingsInitial extends UserSettingsState {}

final class UserSettingsUpdateResult extends UserSettingsState {
  final bool updatingInfoError;
  final bool updatingAvatarError;

  bool get success => !updatingInfoError && !updatingAvatarError;

  bool get error => updatingInfoError || updatingAvatarError;

  UserSettingsUpdateResult({
    required this.updatingInfoError,
    required this.updatingAvatarError,
  });
}
