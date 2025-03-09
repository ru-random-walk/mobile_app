import 'package:auth/src/data/mappers/user.dart';
import 'package:auth/src/data/models/user/page_user.dart';
import 'package:auth/src/domain/entities/user/pageable_users.dart';

extension PageableUsersMapper on PageableUsersModel {
  PageableUsersEntity toDomain() => PageableUsersEntity(
        users: content.map((e) => e.toDomain()).toList(),
        totalPages: totalPages,
        totalElements: totalElements,
        number: number,
        size: size,
      );
}
