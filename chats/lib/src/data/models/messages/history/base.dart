part of '../message.dart';

sealed class BaseHistoryMessageModel extends MessageModel {
  BaseHistoryMessageModel({
    required super.id,
    required super.chatId,
    required super.markedAsRead,
    required super.payload,
    required super.createdAt,
    required super.sender,
  });

  factory BaseHistoryMessageModel.fromJson(Map<String, dynamic> json) {
    final stringType = json['payload']['type'] as String;
    final type = MessageType.fromString(stringType);
    return switch (type) {
      MessageType.text => TextMessageModel.fromJson(json),
      MessageType.requestForWalk => RequestForWalkMessageModel.fromJson(json),
      MessageType.unknown => throw UnimplementedError(),
    };
  }
}
