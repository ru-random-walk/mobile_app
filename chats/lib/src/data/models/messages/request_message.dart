part of 'message.dart';

@JsonSerializable(converters: [
  DateJsonConverter(),
])
class RequestForWalkMessageModel extends MessageModel {
  @override
  @PayloadConverter()
  RequestForWalkPayloadModel get payload =>
      super.payload as RequestForWalkPayloadModel;

  RequestForWalkMessageModel({
    required super.id,
    required super.chatId,
    required super.markedAsRead,
    required super.payload,
    required super.createdAt,
    required super.sender,
  });

  factory RequestForWalkMessageModel.fromJson(Map<String, dynamic> json) =>
      _$RequestForWalkMessageModelFromJson(json);
}
