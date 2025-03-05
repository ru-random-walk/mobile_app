import 'package:chats/src/data/models/messages/message.dart';
import 'package:chats/src/data/models/page_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pageable_messages.g.dart';

@JsonSerializable(createToJson: false)
class PageableMessagesModel {
  final List<MessageModel> content;
  final PageableResponseModel page;

  PageableMessagesModel({
    required this.content,
    required this.page,
  });

  factory PageableMessagesModel.fromJson(Map<String, dynamic> json) =>
      _$PageableMessagesModelFromJson(json);
}
