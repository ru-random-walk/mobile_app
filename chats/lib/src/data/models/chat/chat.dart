import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class ChatModel {
  final String id;
  final List<String> memberIds;

  ChatModel({
    required this.id,
    required this.memberIds,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}
