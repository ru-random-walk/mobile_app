import 'package:auth/src/data/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detailed_user.g.dart';

@JsonSerializable(createToJson: false)
class DetailedUserModel extends UserModel {
  final String email;
  final String? description;
  DetailedUserModel({
    required super.id,
    required super.fullName,
    required this.email,
    required super.avatarVersion,
    required super.description,
    required super.avatar,
  });

  factory DetailedUserModel.fromJson(Map<String, dynamic> json) =>
      _$DetailedUserModelFromJson(json);
}
