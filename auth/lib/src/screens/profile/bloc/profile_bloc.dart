import 'package:auth/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final TokenStorage _tokenStorage;

  ProfileBloc(this._getProfileUseCase, this._tokenStorage)
      : super(ProfileLoading()) {
    NetworkConfig.instance.init(() => add(_UnauthorizeEvent()));
    on<ProfileLoadEvent>(_onProfileLoad);
    on<_UnauthorizeEvent>(_onUnauthorize);
    on<ProfileUpdatedEvent>(
      (event, emit) => emit(
        ProfileData(user: event.user),
      ),
    );
  }

  void _onProfileLoad(ProfileLoadEvent event, Emitter emit) async {
    final res = await _getProfileUseCase();
    res.fold((e) {
      emit(ProfileError(error: e));
    }, (data) {
      emit(ProfileData(user: data));
    });
  }

  void _onUnauthorize(_UnauthorizeEvent event, Emitter emit) async {
    await _tokenStorage.clear();
    emit(ProfileInvalidRefreshToken());
  }
}
