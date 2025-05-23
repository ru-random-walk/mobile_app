import 'package:auth/src/data/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detailed_user.g.dart';

@JsonSerializable()
class DetailedUserModel extends UserModel {
  final String email;
  final String? description;
  DetailedUserModel({
    required super.id,
    required super.fullName,
    required super.avatar,
    required this.email,
    this.description,
  });

  factory DetailedUserModel.fromJson(Map<String, dynamic> json) =>
      _$DetailedUserModelFromJson(json);
}
