import 'package:auth/src/domain/entities/user/user.dart';

class DetailedUserEntity extends UserEntity {
  final String email;
  final String? description;
  DetailedUserEntity({
    required super.id,
    required super.fullName,
    required super.avatar,
    required this.email,
    required this.description,
  });
}
