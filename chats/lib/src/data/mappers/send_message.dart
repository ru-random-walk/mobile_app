import 'package:chats/src/data/models/messages/payload/walk_request/base.dart';
import 'package:chats/src/data/models/messages/socket/request/message_request.dart';
import 'package:chats/src/data/models/messages/payload/text.dart';
import 'package:chats/src/domain/entity/message/base.dart';
import 'package:chats/src/domain/entity/message/send_message.dart';
import 'package:core/core.dart';

extension SendMessageMapper on SendMessageEntity {
  SendMessageModel toModel() {
    final payload = switch (message) {
      TextMessageEntity e => TextPayloadModel(
          text: e.text,
        ),
      InvitationMessageEntity e => RequestForWalkPayloadModelRequest(
          startsAt: e.planDateTimeOfMeeting,
          location: e.place.toModel(),
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
