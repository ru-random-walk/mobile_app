part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginVia extends AuthEvent {
  final AuthProvider type;

  LoginVia(this.type);
}
