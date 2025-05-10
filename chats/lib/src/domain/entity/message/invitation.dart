part of 'base.dart';

class InvitationMessageEntity extends MessageEntity {
  final DateTime planDateTimeOfMeeting;
  final Geolocation place;
  final InvitationStatus status;
  final String? appointmentId;

  TimeOfDay get planTimeOfMeeting =>
      TimeOfDay.fromDateTime(planDateTimeOfMeeting);

  InvitationMessageEntity({
    required this.appointmentId,
    required super.id,
    required super.timestamp,
    required super.isMy,
    required super.isChecked,
    required this.planDateTimeOfMeeting,
    required this.place,
    required this.status,
  });

  InvitationMessageEntity copyWith({
    InvitationStatus? status,
    String? appointmentId,
  }) =>
      InvitationMessageEntity(
        appointmentId: appointmentId ?? this.appointmentId,
        id: id,
        timestamp: timestamp,
        isMy: isMy,
        isChecked: isChecked,
        planDateTimeOfMeeting: planDateTimeOfMeeting,
        place: place,
        status: status ?? this.status,
      );

  bool get showControlButtons => !isMy && status == InvitationStatus.pending;
}
