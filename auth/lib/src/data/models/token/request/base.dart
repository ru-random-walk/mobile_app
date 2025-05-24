import 'package:auth/src/data/models/token/request/email_otp.dart';
import 'package:auth/src/data/models/token/request/refresh.dart';
import 'package:auth/src/data/models/token/request/token_exchange.dart';
import 'package:auth/src/domain/entities/auth_type/base.dart';

abstract class TokenRequestModel {
  final String grantType;

  TokenRequestModel({
    required this.grantType,
  });

  factory TokenRequestModel.via(AuthType authType) => switch (authType) {
        EmailOTPAuthType auth => TokenRequestModel._emailOTP(auth),
        ExternalServiceAuthType auth =>
          TokenRequestModel._viaExternalService(auth),
      };

  factory TokenRequestModel._viaExternalService(
    ExternalServiceAuthType authType,
  ) =>
      TokenExchangeRequestModel(
        grantType: 'urn:ietf:params:oauth:grant-type:token-exchange',
        subjectTokenProvider: authType.provider.name,
        subjectToken: authType.accessToken,
        subjectTokenType: 'Access Token',
      );

  factory TokenRequestModel._emailOTP(EmailOTPAuthType authType) =>
      EmailOTPTokenRequestModel(
        email: authType.email,
        otp: authType.otp,
      );

  factory TokenRequestModel.refresh(String refreshToken) =>
      RefreshTokenRequestModel(
        grantType: 'refresh_token',
        refreshToken: refreshToken,
      );

  Map<String, dynamic> toJson();
}
