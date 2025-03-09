import 'package:auth/src/data/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page_user.g.dart';

@JsonSerializable()
class PageableUsersModel {
  final int totalPages;
  final int totalElements;
  final int number;
  final int size;
  final List<UserModel> content;

  PageableUsersModel({
    required this.totalPages,
    required this.totalElements,
    required this.number,
    required this.size,
    required this.content,
  });

  factory PageableUsersModel.fromJson(Map<String, dynamic> json) =>
      _$PageableUsersModelFromJson(json);
}
