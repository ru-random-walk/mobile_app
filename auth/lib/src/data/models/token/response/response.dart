import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/token/response.dart';

part 'response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TokenResponseModel {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;

  TokenResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory TokenResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseModelToJson(this);

  factory TokenResponseModel.fromEntity(TokenResponseEntity entity) =>
      TokenResponseModel(
        accessToken: entity.accessToken,
        refreshToken: entity.refreshToken,
        tokenType: entity.tokenType,
        expiresIn: entity.expiresIn,
      );

  TokenResponseEntity toEntity() => TokenResponseEntity(
        accessToken: accessToken,
        refreshToken: refreshToken,
        tokenType: tokenType,
        expiresIn: expiresIn,
      );
}
