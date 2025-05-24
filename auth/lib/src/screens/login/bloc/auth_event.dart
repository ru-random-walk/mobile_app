part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginVia extends AuthEvent {
  final AuthProvider type;

  LoginVia(this.type);
}

final class LoginWithEmailOtp extends AuthEvent {
  final String email;
  final String otp;

  LoginWithEmailOtp({required this.email, required this.otp});
}

final class SendEmailOtp extends AuthEvent {
  final String email;

  SendEmailOtp(this.email);
}
