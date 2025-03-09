import 'package:chats/src/domain/entity/message/message.dart';
import 'package:chats/src/domain/entity/message/send_message.dart';

abstract interface class ChatMessagingRepositoryI {
  Stream<MessageEntity> get messagesStream;

  void sendMessage(SendMessageEntity sendMessage);
}