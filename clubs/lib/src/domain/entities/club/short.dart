class ShortClubEntity {
  final String id;
  final String name;

  ShortClubEntity({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) => other is ShortClubEntity && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
