part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}

final class SendOTPFailure extends AuthState {
  final String message;

  SendOTPFailure(this.message);
}

final class SendOTPSuccess extends AuthState {}
