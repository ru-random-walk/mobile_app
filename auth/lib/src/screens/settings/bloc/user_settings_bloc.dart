import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_settings_event.dart';
part 'user_settings_state.dart';

class UserSettingsBloc extends Bloc<UserSettingsEvent, UserSettingsState> {
  UserSettingsBloc() : super(UserSettingsInitial()) {
    on<UserSettingsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
