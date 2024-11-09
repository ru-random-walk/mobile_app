import 'package:auth/src/domain/entities/auth_type/enum.dart';

part 'google.dart';

sealed class AuthType {
  final AuthProvider provider;
  final String accessToken;

  const AuthType(this.provider, this.accessToken);
}
