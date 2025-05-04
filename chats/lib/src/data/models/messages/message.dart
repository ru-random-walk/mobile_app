import 'package:chats/src/data/models/date_converter.dart';
import 'package:chats/src/data/models/messages/payload/payload.dart';
import 'package:chats/src/data/models/messages/payload/text.dart';
import 'package:chats/src/data/models/messages/payload/walk_request/base.dart';
import 'package:chats/src/data/models/messages/type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history/text_message.dart';
part 'history/request_message.dart';
part 'history/base.dart';
part 'socket/response/base.dart';
part 'socket/response/text_message.dart';
part 'socket/response/request_message.dart';
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
}

class PayloadConverter implements JsonConverter<Payload, Map<String, dynamic>> {
  const PayloadConverter();

  @override
  Payload fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    final enumType = MessageType.fromString(type);
    return switch (enumType) {
      MessageType.text => TextPayloadModel.fromJson(json),
      MessageType.requestForWalk => RequestForWalkPayloadModelResponse.fromJson(json),
      MessageType.unknown => throw UnimplementedError(),
    };
  }

  @override
  Map<String, dynamic> toJson(Payload object) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
