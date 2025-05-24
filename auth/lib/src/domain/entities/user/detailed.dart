import 'package:auth/src/domain/entities/user/user.dart';

class DetailedUserEntity extends UserEntity {
  final String email;
  final String? description;
  DetailedUserEntity({
    required super.id,
    required super.fullName,
    required this.email,
    required this.description,
    required super.photoVersion,
    required super.description,
  });
}
