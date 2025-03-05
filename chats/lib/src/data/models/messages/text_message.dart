part of 'message.dart';

@JsonSerializable(converters: [
  DateJsonConverter(),
])
class TextMessageModel extends MessageModel {
  @override
  @PayloadConverter()
  TextPayloadModel get payload => super.payload as TextPayloadModel;

  TextMessageModel({
    required super.id,
    required super.chatId,
    required super.markedAsRead,
    required super.payload,
    required super.createdAt,
    required super.sender,
  });

  factory TextMessageModel.fromJson(Map<String, dynamic> json) =>
      _$TextMessageModelFromJson(json);
}
