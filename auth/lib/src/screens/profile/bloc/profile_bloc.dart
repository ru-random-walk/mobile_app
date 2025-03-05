import 'package:auth/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase _getProfileUseCase;

  ProfileBloc(this._getProfileUseCase) : super(ProfileLoading()) {
    on<ProfileLoadEvent>(_onProfileLoad);
  }

  void _onProfileLoad(ProfileLoadEvent event, Emitter emit) async {
    final res = await _getProfileUseCase();
    res.fold((e) {
      emit(ProfileError(error: e));
    }, (data) {
      emit(ProfileData(user: data));
    });
  }
}
