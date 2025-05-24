import 'package:auth/src/domain/entities/user/user.dart';

class DetailedUserEntity extends UserEntity {
  final String email;
  DetailedUserEntity({
    required super.id,
    required super.fullName,
    required this.email,
    required super.photoVersion,
    required super.description,
  });
}
