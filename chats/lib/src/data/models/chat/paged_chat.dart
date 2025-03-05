import 'package:chats/src/data/models/chat/chat.dart';
import 'package:chats/src/data/models/page_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paged_chat.g.dart';

@JsonSerializable()
class PageableChatModel {
  final List<ChatModel> content;
  final PageableResponseModel page;

  PageableChatModel({
    required this.content,
    required this.page,
  });

  factory PageableChatModel.fromJson(Map<String, dynamic> json) =>
      _$PageableChatModelFromJson(json);
}
