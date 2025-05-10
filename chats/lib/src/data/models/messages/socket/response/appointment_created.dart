part of '../../message.dart';

@JsonSerializable(createToJson: false)
class AppointmentCreatedSocketEventModel extends SocketEventModel {
  final String messageId;
  final String appointmentId;

  AppointmentCreatedSocketEventModel({
    required this.messageId,
    required this.appointmentId,
  });

  factory AppointmentCreatedSocketEventModel.fromJson(
          Map<String, dynamic> json) =>
      _$AppointmentCreatedSocketEventModelFromJson(json);
}
