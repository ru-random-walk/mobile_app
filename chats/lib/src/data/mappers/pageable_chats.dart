import 'package:auth/auth.dart';
import 'package:chats/src/data/mappers/chat.dart';
import 'package:chats/src/data/models/chat/paged_chat.dart';
import 'package:chats/src/domain/entity/chat/pageable_chat.dart';
import 'package:core/core.dart';

extension PageableMapper on PageableChatModel {
  PageableChats toDomain(List<UserModel> companions) {
    final chatsEntity = content.asMap().entries.map((e) {
      final chat = e.value;
      final companion = companions.firstWhere(
        (element) => element.id == 'ab4c22b2-a577-4aef-91e1-c8a8be8851d9',
      );
      return chat.toDomain(companion.toDomain());
    }).toList();
    return PageableChats(
      chats: chatsEntity,
      pageInfo: page.toDomain(),
    );
  }
}
