import 'package:auth/auth.dart';
import 'package:auth/src/domain/entities/user/update_user_info.dart';
import 'package:auth/src/domain/usecases/user/update_info.dart';
import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:meta/meta.dart';

part 'user_settings_event.dart';
part 'user_settings_state.dart';

class UserSettingsBloc extends Bloc<UserSettingsEvent, UserSettingsState> {
  final UpdateUserInfoUseCase _updateUserInfoUseCase;
  final SetPhotoForObjectWithId _setPhotoForObjectWithId;
  final void Function(DetailedUserEntity user) _onUserUpdate;

  UserSettingsBloc(
    this._updateUserInfoUseCase,
    this._setPhotoForObjectWithId,
    this._onUserUpdate,
  ) : super(UserSettingsInitial()) {
    on<UpdateUserSettings>(_onUpdateUserSettings);
  }

  void _onUpdateUserSettings(UpdateUserSettings event, Emitter emit) async {
    final updateInfo = event.updateInfo;
    final updateAvatar = event.photo;
    if (updateInfo == null && updateAvatar == null) return;
    bool errorInfoUpdating = false;
    bool errorAvatarUpdating = false;
    if (updateInfo != null) {
      final infoUpdatingResult = await _updateUserInfoUseCase(updateInfo);
      infoUpdatingResult.fold((_) {
        errorInfoUpdating = true;
      }, (user) {
        _onUserUpdate(user);
        errorInfoUpdating = false;
      });
    }
    if (updateAvatar != null) {
      final avatarUpdatingResult = await _setPhotoForObjectWithId(updateAvatar);
      avatarUpdatingResult.fold((_) {
        errorAvatarUpdating = true;
      }, (_) {
        errorAvatarUpdating = false;
      });
    }
    emit(
      UserSettingsUpdateResult(
        updatingInfoError: errorInfoUpdating,
        updatingAvatarError: errorAvatarUpdating,
      ),
    );
  }
}
