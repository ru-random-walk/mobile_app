part of 'message.dart';

class InvitationMessageEntity extends MessageEntity {
  final DateTime planDateOfMeeting;
  final TimeOfDay planTimeOfMeeting;
  final Geolocation place;
  final InvitationStatus status;

  InvitationMessageEntity({
    required super.timestamp,
    required super.isMy,
    required super.isChecked,
    required this.planDateOfMeeting,
    required this.planTimeOfMeeting,
    required this.place,
    required this.status,
  });

  bool get showControlButtons => !isMy && status == InvitationStatus.pending;
}

abstract class A<T> {
  final String name;

  final T value;

  A({required this.name, required this.value});
}

class C extends A<InvitationMessageEntity> {
  C({required super.name, required super.value});
}
