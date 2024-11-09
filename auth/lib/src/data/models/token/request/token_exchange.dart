import 'package:auth/src/data/models/token/request/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_exchange.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TokenExchangeRequestModel extends TokenRequestModel {
  final String subjectTokenProvider;
  final String subjectToken;
  final String subjectTokenType;

  TokenExchangeRequestModel({
    required super.grantType,
    required this.subjectTokenProvider,
    required this.subjectToken,
    required this.subjectTokenType,
  });

  factory TokenExchangeRequestModel.fromJson(Map<String, dynamic> json) =>
      _$TokenExchangeRequestModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TokenExchangeRequestModelToJson(this);
}
