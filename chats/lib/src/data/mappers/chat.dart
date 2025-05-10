import 'package:auth/auth.dart';
import 'package:chats/src/data/models/chat/chat.dart';
import 'package:chats/src/domain/entity/chat/chat.dart';
import 'package:chats/src/domain/entity/message/base.dart';

extension ChatMapper on ChatModel {
  ChatEntity toDomain(UserEntity companion, MessageEntity? lastMessage) =>
      ChatEntity(
        id: id,
        companion: companion,
        lastMessage: lastMessage,
      );
}
