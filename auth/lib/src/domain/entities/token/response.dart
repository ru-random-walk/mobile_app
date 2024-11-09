class TokenResponseEntity {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;

  TokenResponseEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
  });
}
