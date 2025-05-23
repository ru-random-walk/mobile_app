class UserEntity {
  final String id;
  final String fullName;
  final String? avatar;
  final int photoVersion;

  UserEntity({
    required this.id,
    required this.fullName,
    required this.avatar,
    required this.photoVersion,
  });
}
