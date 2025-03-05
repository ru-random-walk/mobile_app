import 'package:chats/src/data/mappers/page_response.dart';
import 'package:chats/src/data/models/chat/paged_chat.dart';
import 'package:chats/src/domain/entity/chat/chat.dart';
import 'package:chats/src/domain/entity/chat/pageable_chat.dart';

extension PageableMapper on PageableChatModel {
  PageableChats toDomain() => PageableChats(
        chats: content.map((e) => ChatEntity(id: e.id)).toList(),
        pageInfo: page.toDomain(),
      );
}
