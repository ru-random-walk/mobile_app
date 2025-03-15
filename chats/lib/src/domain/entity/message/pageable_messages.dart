import 'package:chats/src/domain/entity/message/message.dart';
import 'package:core/core.dart';

class PageableMessagesEntity {
  final List<MessageEntity> messages;
  final PageableResponse pageInfo;

  PageableMessagesEntity({
    required this.messages,
    required this.pageInfo,
  });
}
