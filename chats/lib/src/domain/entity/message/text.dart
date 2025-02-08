part of 'message.dart';

class TextMessageEntity extends MessageEntity {
  final String text;

  TextMessageEntity({
    required super.timestamp,
    required super.isMy,
    required super.isChecked,
    required this.text,
  });
}
