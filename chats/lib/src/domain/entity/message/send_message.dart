import 'package:chats/src/domain/entity/message/message.dart';

class SendMessageEntity {
  final MessageEntity message;
  final String chatId;
  final String sender;
  final String recepient;
  final DateTime createdAt;

  SendMessageEntity({
    required this.message,
    required this.chatId,
    required this.sender,
    required this.recepient,
    required this.createdAt,
  });
}
