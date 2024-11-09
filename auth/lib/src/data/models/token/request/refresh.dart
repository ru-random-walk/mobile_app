import 'package:auth/src/data/models/token/request/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refresh.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RefreshTokenRequestModel extends TokenRequestModel {
  final String refreshToken;

  RefreshTokenRequestModel({
    required super.grantType,
    required this.refreshToken,
  });

  factory RefreshTokenRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RefreshTokenRequestModelToJson(this);
}
