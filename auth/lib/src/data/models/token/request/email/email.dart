import 'package:json_annotation/json_annotation.dart';

part 'email.g.dart';

@JsonSerializable(createFactory: false)
class RequestEmailOTPModel {
  final String email;

  RequestEmailOTPModel({required this.email});

  Map<String, dynamic> toJson() => _$RequestEmailOTPModelToJson(this);
}
