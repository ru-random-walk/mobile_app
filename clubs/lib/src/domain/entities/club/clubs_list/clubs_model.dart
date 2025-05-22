part of 'page.dart';

class ClubModel {
  final String id;
  final String name;
  final int membersCount;
  final String userRole;
  final int photoVersion;

  ClubModel({
    required this.id,
    required this.name,
    required this.membersCount,
    required this.userRole,
    required this.photoVersion,
  });

  factory ClubModel.fromUserClub(dynamic json) {
    return ClubModel(
      id: json['club']['id'],
      name: json['club']['name'],
      membersCount: List<String>.from(
        (json['club']['members'] as List).map((m) => m['id']),
      ).length,
      userRole: json['userRole'],
      photoVersion: json['club']['photoVersion'] ?? 0,
    );
  }

  factory ClubModel.fromSearchResult(dynamic json) {
    return ClubModel(
      id: json['id'],
      name: json['name'],
      membersCount: List<String>.from(
        (json['members'] as List).map((m) => m['id']),
      ).length,
      userRole: 'NOT_MEMBER',
      photoVersion: json['photoVersion'] ?? 0,
    );
  }
}
