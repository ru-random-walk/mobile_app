part of 'base.dart';

class AppointmentCreatedSocketEvent extends ChatSocketEvent {
  final String messageId;
  final String appointmentId;

  AppointmentCreatedSocketEvent({
    required this.messageId,
    required this.appointmentId,
  });
}
