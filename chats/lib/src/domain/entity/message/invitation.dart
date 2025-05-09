part of 'base.dart';

class InvitationMessageEntity extends MessageEntity {
  final DateTime planDateTimeOfMeeting;
  final Geolocation place;
  final InvitationStatus status;

  TimeOfDay get planTimeOfMeeting =>
      TimeOfDay.fromDateTime(planDateTimeOfMeeting);

  InvitationMessageEntity({
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
  }) =>
      InvitationMessageEntity(
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
