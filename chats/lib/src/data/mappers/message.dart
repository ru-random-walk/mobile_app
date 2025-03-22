import 'package:chats/src/data/models/messages/message.dart';
import 'package:chats/src/domain/entity/message/message.dart';
import 'package:core/core.dart';

extension MessageMapper on MessageModel {
  MessageEntity toDomain(String currentUserId) {
    final isMy = sender == currentUserId;
    final isChecked = markedAsRead;
    final timestamp = createdAt;
    return switch (this) {
      final TextMessageModel message => TextMessageEntity(
          timestamp: timestamp,
          isMy: isMy,
          isChecked: isChecked,
          text: message.payload.text,
        ),
      final RequestForWalkMessageModel message => InvitationMessageEntity(
          timestamp: timestamp,
          isMy: isMy,
          isChecked: isChecked,
          planDateTimeOfMeeting: message.payload.startsAt,
          place: message.payload.location.toDomain(),
          status: statusFromBool(message.payload.answer),
        ),
    };
  }

  InvitationStatus statusFromBool(bool? answer) => switch (answer) {
        true => InvitationStatus.accepted,
        false => InvitationStatus.rejected,
        null => InvitationStatus.pending,
      };
}
