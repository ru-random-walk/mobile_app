part of 'message.dart';

class InvitationMessageEntity extends MessageEntity {
  final DateTime planDateTimeOfMeeting;
  final Geolocation place;
  final InvitationStatus status;

  TimeOfDay get planTimeOfMeeting =>
      TimeOfDay.fromDateTime(planDateTimeOfMeeting);

  InvitationMessageEntity({
    required super.timestamp,
    required super.isMy,
    required super.isChecked,
    required this.planDateTimeOfMeeting,
    required this.place,
    required this.status,
  });

  bool get showControlButtons => !isMy && status == InvitationStatus.pending;
}
