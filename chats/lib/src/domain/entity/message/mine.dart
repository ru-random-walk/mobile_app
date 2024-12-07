part of 'message.dart';

class MyMessageEntity extends TextMessageEntity {
  final bool isChecked;

  MyMessageEntity({
    required super.text,
    required super.timestamp,
    required this.isChecked,
  });
}
