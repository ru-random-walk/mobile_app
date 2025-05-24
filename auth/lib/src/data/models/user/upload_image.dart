import 'package:json_annotation/json_annotation.dart';

part 'upload_image.g.dart';

@JsonSerializable(createFactory: false)
class UploadUserAvatarModel {
  final String file;

  UploadUserAvatarModel({required this.file});

  Map<String, dynamic> toJson() => _$UploadUserAvatarModelToJson(this);
}
