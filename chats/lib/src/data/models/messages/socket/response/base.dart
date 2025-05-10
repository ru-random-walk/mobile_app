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

    final payload = json['payload'] as Map<String, dynamic>?;
    switch (payload) {
      case null:
        final appointmentId = json['appointmentId'] as String?;
        switch (appointmentId) {
          case null:
            return WalkRequestStatusChangedModel.fromJson(json);
          case String _:
            return AppointmentCreatedSocketEventModel.fromJson(json);
        }
      case Map<String, dynamic> _:
        final stringType = payload['type'] as String;
        return parseMessage(stringType);
    }
  }
}
