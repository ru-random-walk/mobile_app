import 'package:auth/src/domain/entities/auth_type/enum.dart';

part 'google.dart';

sealed class AuthType {
  const AuthType();
}

class EmailOTPAuthType extends AuthType {
  final String email;
  final String otp;

  const EmailOTPAuthType({
    required this.email,
    required this.otp,
  });
}

sealed class ExternalServiceAuthType extends AuthType {
  final AuthProvider provider;
  final String accessToken;

  const ExternalServiceAuthType(this.provider, this.accessToken);
}
