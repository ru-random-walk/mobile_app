import 'package:core/core.dart';

class UserEntity implements GetObjectPhotoArgs {
  final String id;
  final String fullName;
  final String? description;
  final String? avatar;

  @override
  final int photoVersion;

  @override
  String get objectId => id;

  UserEntity({
    required this.id,
    required this.fullName,
    required this.photoVersion,
    required this.description,
    required this.avatar,
  });
}
