part of 'base.dart';

class AuthViaGoogle extends AuthType {
  AuthViaGoogle(String accessToken) : super(AuthProvider.google, accessToken);
}
