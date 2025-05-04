part of '../message.dart';

@JsonSerializable(converters: [
  DateJsonConverter(),
])
class RequestForWalkMessageModel extends BaseHistoryMessageModel {
  @override
  @PayloadConverter()
  RequestForWalkPayloadModelResponse get payload =>
      super.payload as RequestForWalkPayloadModelResponse;

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
