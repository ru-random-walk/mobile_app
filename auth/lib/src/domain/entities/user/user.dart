class UserEntity {
  final String id;
  final String fullName;
  final String? description;
  final int photoVersion;

  UserEntity({
    required this.id,
    required this.fullName,
    required this.photoVersion,
    required this.description,
  });
}
