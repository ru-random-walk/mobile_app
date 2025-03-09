import 'package:chats/src/data/models/messages/type.dart';

abstract class Payload {
  final MessageType type;

  Payload({required this.type});

  Map<String, dynamic> toJson();
}
