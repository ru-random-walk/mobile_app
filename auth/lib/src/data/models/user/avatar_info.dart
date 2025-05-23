import 'package:json_annotation/json_annotation.dart';

part 'avatar_info.g.dart';

@JsonSerializable(createToJson: false)
class UserAvatarInfoModel {
  final String userId;
  final int avatarVersion;
  final String? avatarUrl;
  final DateTime? expiresAt;

  UserAvatarInfoModel({
    required this.userId,
    required this.avatarVersion,
    required this.avatarUrl,
    required this.expiresAt,
  });

  factory UserAvatarInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserAvatarInfoModelFromJson(json);
}
