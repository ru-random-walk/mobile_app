part of 'base.dart';

sealed class MessageEntity extends ChatSocketEvent {
  final String? id;
  final DateTime timestamp;
  final bool isMy;
  final bool isChecked;

  MessageEntity({
    required this.id,
    required this.isChecked,
    required this.timestamp,
    required this.isMy,
  });
}
