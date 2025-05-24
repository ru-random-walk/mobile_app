import 'package:auth/src/domain/usecases/user/logout.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final LogoutUseCase _logoutUseCase;

  SettingsBloc(this._logoutUseCase) : super(SettingsInitial()) {
    on<SettingsLogoutEvent>((_, emit) async {
      final res = await _logoutUseCase();
      res.fold((e) {
        emit(SettingsLogoutError());
      }, (_) {
        emit(SettingsLogoutSuccess());
      });
    });
  }
}
