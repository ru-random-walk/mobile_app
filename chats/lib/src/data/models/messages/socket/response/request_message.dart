part of '../../message.dart';

@JsonSerializable(createToJson: false)
class RequestForWalkSocketResponseMessageModel
    extends BaseSocketResponseMessageModel {
  @override
  @PayloadConverter()
  RequestForWalkPayloadModel get payload =>
      super.payload as RequestForWalkPayloadModel;

  @override
  @JsonKey(name: 'sentAt')
  DateTime get createdAt => super.createdAt;

  RequestForWalkSocketResponseMessageModel({
    required super.id,
    required super.chatId,
    required super.markedAsRead,
    required super.payload,
    required super.createdAt,
    required super.sender,
  });

  factory RequestForWalkSocketResponseMessageModel.fromJson(
          Map<String, dynamic> json) =>
      _$RequestForWalkSocketResponseMessageModelFromJson(json);
}