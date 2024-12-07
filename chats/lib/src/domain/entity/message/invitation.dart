part of 'message.dart';

class InvitationMessageEntity extends MessageEntity {
  final DateTime planDateTimeOfMeeting;
  final String place;
  final InvitationStatus status;
  final bool _isFromMe;

  InvitationMessageEntity({
    required super.timestamp,
    required this.planDateTimeOfMeeting,
    required this.place,
    required bool isFromMe,
    required this.status,
  }) : _isFromMe = isFromMe;


  bool get showControlButtons => _isFromMe && status == InvitationStatus.pending;
}
