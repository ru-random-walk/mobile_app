import 'package:chats/src/data/models/messages/type.dart';

abstract class Payload {
  final MessageType type;

  Payload({required this.type});
}

abstract interface class SendablePayload extends Payload {
  SendablePayload({required super.type});

  Map<String, dynamic> toJson();
}
