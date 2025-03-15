import 'package:auth/auth.dart';
import 'package:core/core.dart';

class PageableUsersEntity {
  final List<UserEntity> users;
  final PageableResponse pageInfo;

  PageableUsersEntity({
    required this.users,
    required this.pageInfo,
  });
}
