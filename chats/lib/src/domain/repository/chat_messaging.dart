import 'package:chats/src/domain/entity/message/base.dart';
import 'package:chats/src/domain/entity/message/send_message.dart';

abstract interface class ChatMessagingRepositoryI {
  Stream<ChatSocketEvent> get messagesStream;

  void sendMessage(SendMessageEntity sendMessage);

  void dispose();
}