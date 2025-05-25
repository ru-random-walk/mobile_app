import 'package:auth/src/data/models/user/user.dart';
import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page_user.g.dart';

@JsonSerializable(createToJson: false)
class PageableUsersModel {
  final PageableResponseModel page;
  final List<UserModel> content;

  PageableUsersModel({
    required this.page,
    required this.content,
  });

  factory PageableUsersModel.fromJson(Map<String, dynamic> json) =>
      _$PageableUsersModelFromJson(json);
}
