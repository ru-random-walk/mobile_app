import 'package:auth/src/domain/entities/auth_type/base.dart';
import 'package:auth/src/domain/entities/auth_type/enum.dart';
import 'package:auth/src/domain/usecases/email_otp_auth.dart';
import 'package:auth/src/domain/usecases/google_auth.dart';
import 'package:auth/src/domain/usecases/send_email_otp.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:utils/utils.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleAuthUseCase _authUseCase;
  final EmailOTPAuthUseCase _emailOTPAuthUseCase;
  final SendEmailOTPUseCase _sendEmailOTPUseCase;

  AuthBloc(
    this._authUseCase,
    this._emailOTPAuthUseCase,
    this._sendEmailOTPUseCase,
  ) : super(AuthInitial()) {
    on<LoginVia>(_onLoginVia);
    on<LoginWithEmailOtp>(_onLoginWithEmailOTP);
    on<SendEmailOtp>(_onSendEmailOtp);
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

  Future<void> _onLoginWithEmailOTP(
    LoginWithEmailOtp event,
    Emitter emit,
  ) async {
    emit(AuthLoading());
    final res = await _emailOTPAuthUseCase(
      EmailOTPAuthType(
        email: event.email,
        otp: event.otp,
      ),
    );
    res.fold((e) {
      emit(AuthFailure(e.message));
    }, (_) {
      emit(AuthSuccess());
    });
  }

  Future<void> _onSendEmailOtp(SendEmailOtp event, Emitter emit) async {
    final res = await _sendEmailOTPUseCase(event.email);
    res.fold((e) {
      emit(SendOTPFailure(e.message));
    }, (_) {
      emit(SendOTPSuccess());
    });
  }

  Future<Either<BaseError, void>> _loginViaGoogle() {
    return _authUseCase(AuthProvider.google);
  }
}
