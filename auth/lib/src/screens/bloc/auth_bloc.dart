import 'package:auth/src/domain/entities/auth_type/enum.dart';
import 'package:auth/src/domain/usecases/google_sign_in.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetGoogleAccessTokenUseCase _getGoogleAccessTokenUseCase;

  AuthBloc(this._getGoogleAccessTokenUseCase) : super(AuthInitial()) {
    on<LoginVia>(_onLoginVia);
  }

  void _onLoginVia(LoginVia event, Emitter emit) {
    emit(AuthLoading());

  }

  void _loginViaGoogle(){

  }
}
