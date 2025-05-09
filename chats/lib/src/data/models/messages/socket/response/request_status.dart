part of '../../message.dart';

@JsonSerializable(createToJson: false)
class WalkRequestStatusChangedModel extends SocketEventModel {
  final String messageId;
  final bool isAcccepted;

  WalkRequestStatusChangedModel({
    required this.messageId,
    required this.isAcccepted,
  });

  factory WalkRequestStatusChangedModel.fromJson(Map<String, dynamic> json) =>
      _$WalkRequestStatusChangedModelFromJson(json);
}
