import 'package:auth/auth.dart';
import 'package:chats/src/domain/entity/message/message.dart';

class ChatEntity {
  final String id;
  final UserEntity companion;
  final MessageEntity? lastMessage;

  ChatEntity({
    required this.id,
    required this.companion,
    required this.lastMessage,
  });

  ChatEntity copyWith({
    MessageEntity? lastMessage,
  }) =>
      ChatEntity(
        id: id,
        companion: companion,
        lastMessage: lastMessage ?? this.lastMessage,
      );
}
