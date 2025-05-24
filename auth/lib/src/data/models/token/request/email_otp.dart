import 'package:auth/src/data/models/token/request/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email_otp.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createFactory: false,
)
class EmailOTPTokenRequestModel extends TokenRequestModel {
  final String otp;
  final String email;

  EmailOTPTokenRequestModel({
    required this.otp,
    required this.email,
  }) : super(grantType: 'email_otp');

  @override
  Map<String, dynamic> toJson() => _$EmailOTPTokenRequestModelToJson(this);
}
