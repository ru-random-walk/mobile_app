part of 'message.dart';

sealed class TextMessageEntity extends MessageEntity {
  final String text;

  TextMessageEntity({
    required super.timestamp,
    required this.text,
  });
}