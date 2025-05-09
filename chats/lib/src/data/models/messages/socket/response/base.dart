part of '../../message.dart';

sealed class SocketEventModel {
  const SocketEventModel();

  factory SocketEventModel.fromJson(Map<String, dynamic> json) {
    BaseSocketResponseMessageModel parseMessage(String stringType) {
      final type = MessageType.fromString(stringType);
      return switch (type) {
        MessageType.text => TextSocketResponseMessageModel.fromJson(json),
        MessageType.requestForWalk =>
          RequestForWalkSocketResponseMessageModel.fromJson(json),
        MessageType.unknown => throw UnimplementedError(),
      };
    }

    final stringType = json['payload']['type'] as String?;
    switch (stringType) {
      case null:
        return WalkRequestStatusChangedModel.fromJson(json);
      case String value:
        return parseMessage(value);
    }
  }
}
