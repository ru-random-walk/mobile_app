import 'package:chats/src/data/models/messages/payload.dart';
import 'package:chats/src/data/models/messages/text.dart';
import 'package:chats/src/data/models/messages/type.dart';
import 'package:chats/src/data/models/messages/walk_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'text_message.dart';
part 'request_message.dart';
part 'message.g.dart';

sealed class MessageModel {
  final String id;
  final String chatId;
  final Payload payload;
  final bool markedAsRead;
  final DateTime createdAt;
  final String sender;

  const MessageModel({
    required this.id,
    required this.chatId,
    required this.markedAsRead,
    required this.payload,
    required this.createdAt,
    required this.sender,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final stringType = json['payload']['type'] as String;
    final type = MessageType.fromString(stringType);
    return switch (type) {
      MessageType.text => TextMessageModel.fromJson(json),
      MessageType.requestForWalk => RequestForWalkMessageModel.fromJson(json),
      MessageType.unknown => throw UnimplementedError(),
    };
  }
}

class PayloadConverter implements JsonConverter<Payload, Map<String, dynamic>> {
  const PayloadConverter();

  @override
  Payload fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson(Payload object) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
