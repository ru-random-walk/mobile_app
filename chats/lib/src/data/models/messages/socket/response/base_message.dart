part of '../../message.dart';

sealed class BaseSocketResponseMessageModel extends SocketEventModel
    implements MessageModel {
  @override
  final String id;
  @override
  final String chatId;
  @override
  final Payload payload;
  @override
  final bool markedAsRead;
  @override
  final DateTime createdAt;
  @override
  final String sender;

  const BaseSocketResponseMessageModel({
    required this.id,
    required this.chatId,
    required this.markedAsRead,
    required this.payload,
    required this.createdAt,
    required this.sender,
  });
}
