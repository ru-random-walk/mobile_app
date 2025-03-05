import 'package:auth/src/domain/entities/auth_type/enum.dart';
import 'package:auth/src/domain/usecases/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:meta/meta.dart';
import 'package:utils/utils.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;

  AuthBloc(this._authUseCase) : super(AuthInitial()) {
    on<LoginVia>(_onLoginVia);
  }

  Future<void> _onLoginVia(LoginVia event, Emitter emit) async {
    emit(AuthLoading());
    final res = switch (event.type) {
      AuthProvider.google => await _loginViaGoogle(),
    };
    res.fold((e) {
      emit(AuthFailure(e.message));
    }, (_) {
      emit(AuthSuccess());
    });
  }

  Future<Either<BaseError, void>> _loginViaGoogle() {
    return _authUseCase(AuthProvider.google);
  }
}
