part of '../../message.dart';

@JsonSerializable()
class TextSocketResponseMessageModel extends BaseSocketResponseMessageModel {
  @override
  @PayloadConverter()
  TextPayloadModel get payload => super.payload as TextPayloadModel;

  @override
  @JsonKey(name: 'sentAt')
  DateTime get createdAt => super.createdAt;

  TextSocketResponseMessageModel({
    required super.id,
    required super.chatId,
    required super.markedAsRead,
    required super.payload,
    required super.createdAt,
    required super.sender,
  });

  factory TextSocketResponseMessageModel.fromJson(Map<String, dynamic> json) =>
      _$TextSocketResponseMessageModelFromJson(json);
}
