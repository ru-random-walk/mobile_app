part of '../../message.dart';

sealed class BaseSocketResponseMessageModel extends MessageModel {
  BaseSocketResponseMessageModel({
    required super.id,
    required super.chatId,
    required super.markedAsRead,
    required super.payload,
    required super.createdAt,
    required super.sender,
  });

  factory BaseSocketResponseMessageModel.fromJson(Map<String, dynamic> json) {
    final stringType = json['payload']['type'] as String;
    final type = MessageType.fromString(stringType);
    return switch (type) {
      MessageType.text => TextSocketResponseMessageModel.fromJson(json),
      MessageType.requestForWalk => RequestForWalkSocketResponseMessageModel.fromJson(json),
      MessageType.unknown => throw UnimplementedError(),
    };
  }
}
