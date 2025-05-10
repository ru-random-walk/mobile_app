part of 'base.dart';

class TextMessageEntity extends MessageEntity {
  final String text;

  TextMessageEntity({
    required super.id,
    required super.timestamp,
    required super.isMy,
    required super.isChecked,
    required this.text,
  });
}
