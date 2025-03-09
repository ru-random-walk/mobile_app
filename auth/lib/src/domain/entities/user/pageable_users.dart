import 'package:auth/auth.dart';

class PageableUsersEntity {
  final List<UserEntity> users;
  final int totalPages;
  final int totalElements;
  final int number;
  final int size;

  PageableUsersEntity({
    required this.users,
    required this.totalPages,
    required this.totalElements,
    required this.number,
    required this.size,
  });
}
