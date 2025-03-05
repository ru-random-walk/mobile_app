import 'package:chats/src/domain/entity/chat/page_response.dart';
import 'package:chats/src/domain/entity/message/message.dart';

class PageableMessagesEntity {
  final List<MessageEntity> messages;
  final PageableResponse pageInfo;

  PageableMessagesEntity({
    required this.messages,
    required this.pageInfo,
  });
}
