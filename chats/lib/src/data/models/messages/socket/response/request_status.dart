part of '../../message.dart';

@JsonSerializable(createToJson: false)
class WalkRequestStatusChangedModel extends SocketEventModel {
  final String messageId;
  final bool isAccepted;

  WalkRequestStatusChangedModel({
    required this.messageId,
    required this.isAccepted,
  });

  factory WalkRequestStatusChangedModel.fromJson(Map<String, dynamic> json) =>
      _$WalkRequestStatusChangedModelFromJson(json);
}
