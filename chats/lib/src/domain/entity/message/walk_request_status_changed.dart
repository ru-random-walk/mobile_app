part of 'base.dart';

class WalkRequestStatusChanged extends ChatSocketEvent {
  final String messageId;
  final bool isAcccepted;

  WalkRequestStatusChanged({
    required this.messageId,
    required this.isAcccepted,
  });
}
