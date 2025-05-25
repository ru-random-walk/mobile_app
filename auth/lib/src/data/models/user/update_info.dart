import 'package:json_annotation/json_annotation.dart';

part 'update_info.g.dart';

@JsonSerializable(createFactory: false)
class UpdateInfoUserModel {
  final String fullName;
  final String? aboutMe;

  UpdateInfoUserModel({
    required this.fullName,
    required this.aboutMe,
  });

  Map<String, dynamic> toJson() => _$UpdateInfoUserModelToJson(this);
}
