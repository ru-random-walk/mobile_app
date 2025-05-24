import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(createToJson: false)
class UserModel {
  final String id;
  final String fullName;
  final String? description;
  final String? avatar;
  final int avatarVersion;

  UserModel({
    required this.id,
    required this.fullName,
    required this.avatarVersion,
    required this.avatar,
    required this.description,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
