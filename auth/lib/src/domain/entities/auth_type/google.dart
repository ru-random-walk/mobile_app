part of 'base.dart';

class AuthViaGoogle extends ExternalServiceAuthType {
  AuthViaGoogle(String accessToken) : super(AuthProvider.google, accessToken);
}
