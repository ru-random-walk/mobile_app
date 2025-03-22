import 'package:chats/src/data/models/messages/message_request.dart';
import 'package:chats/src/data/models/messages/text.dart';
import 'package:chats/src/data/models/messages/walk_request.dart';
import 'package:chats/src/domain/entity/message/message.dart';
import 'package:chats/src/domain/entity/message/send_message.dart';
import 'package:core/core.dart';

extension SendMessageMapper on SendMessageEntity {
  SendMessageModel toModel() {
    final payload = switch (message) {
      TextMessageEntity e => TextPayloadModel(
          text: e.text,
        ),
      InvitationMessageEntity e =>  RequestForWalkPayloadModel(
          startsAt: e.planDateTimeOfMeeting,
          location: e.place.toModel(),
          answer: null,
      ),
    };
    return SendMessageModel(
      payload: payload,
      chatId: chatId,
      sender: sender,
      recipient: recepient,
      createdAt: createdAt,
    );
  }
}
