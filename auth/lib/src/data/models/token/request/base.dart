import 'package:auth/src/data/models/token/request/refresh.dart';
import 'package:auth/src/data/models/token/request/token_exchange.dart';
import 'package:auth/src/domain/entities/auth_type/base.dart';

abstract class TokenRequestModel {
  final String grantType;

  TokenRequestModel({
    required this.grantType,
  });

  factory TokenRequestModel.via(AuthType authType) => TokenExchangeRequestModel(
        grantType: 'urn:ietf:params:oauth:grant-type:token-exchange',
        subjectTokenProvider: authType.accessToken,
        subjectToken: authType.provider.name,
        subjectTokenType: 'Access Token',
      );

  factory TokenRequestModel.refresh(String refreshToken) =>
      RefreshTokenRequestModel(
        grantType: 'refresh_token',
        refreshToken: refreshToken,
      );

  Map<String, dynamic> toJson();
}
