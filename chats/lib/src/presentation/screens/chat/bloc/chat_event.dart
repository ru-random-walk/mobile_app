part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class TextMessageSended extends ChatEvent {
  final String message;

  TextMessageSended({required this.message});
}

final class InviteMessageSended extends ChatEvent {
  final InviteEntity invite;

  InviteMessageSended({required this.invite});
}

final class _MessageRecieved extends ChatEvent {
  final MessageEntity message;

  _MessageRecieved({required this.message});
}

final class LoadData extends ChatEvent {
  final String companionId;

  LoadData(this.companionId);
}

sealed class AppointmentRequestDecision extends ChatEvent {
  final String messageId;
  final String appointmentId;

  AppointmentRequestDecision({
    required this.appointmentId,
    required this.messageId,
  });
}

final class RejectAppointmentRequest extends AppointmentRequestDecision {
  RejectAppointmentRequest({
    required super.appointmentId,
    required super.messageId,
  });
}

final class ApproveAppointmentRequest extends AppointmentRequestDecision {
  ApproveAppointmentRequest({
    required super.appointmentId,
    required super.messageId,
  });
}

final class _WalkRequestStatusChangedEvent extends ChatEvent {
  final WalkRequestStatusChanged event;

  _WalkRequestStatusChangedEvent({required this.event});
}

final class _AppointmentCreate extends ChatEvent {
  final AppointmentCreatedSocketEvent event;

  _AppointmentCreate({required this.event});
}
