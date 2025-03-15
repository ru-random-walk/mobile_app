import 'package:auth/auth.dart';
import 'package:chats/src/data/models/chat/chat.dart';
import 'package:chats/src/domain/entity/chat/chat.dart';

extension ChatMapper on ChatModel {
  ChatEntity toDomain(UserEntity companion) => ChatEntity(
        id: id,
        companion: companion,
      );
}
