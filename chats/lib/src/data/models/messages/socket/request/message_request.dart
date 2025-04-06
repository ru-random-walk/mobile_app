import 'package:chats/src/data/models/messages/payload/payload.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_request.g.dart';

@JsonSerializable(
  explicitToJson: true,
  createFactory: false,
)
class SendMessageModel {
  Payload payload;
  String chatId;
  String sender;
  String recipient;
  DateTime createdAt;

  SendMessageModel({
    required this.payload,
    required this.chatId,
    required this.sender,
    required this.recipient,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => _$SendMessageModelToJson(this);
}
