import 'package:chats/src/data/mappers/message.dart';
import 'package:chats/src/data/models/messages/message.dart';
import 'package:chats/src/domain/entity/message/base.dart';

extension SocketEventMapper on SocketEventModel {
  ChatSocketEvent toDomain(String currentUserId) {
    return switch (this) {
      final WalkRequestStatusChangedModel event => WalkRequestStatusChanged(
          isAcccepted: event.isAccepted,
          messageId: event.messageId,
        ),
      final MessageModel msg => msg.toDomain(currentUserId),
      final AppointmentCreatedSocketEventModel event =>
        AppointmentCreatedSocketEvent(
          messageId: event.messageId,
          appointmentId: event.appointmentId,
        ),
    };
  }
}
