import 'package:chats/src/domain/entity/message/base.dart';
import 'package:core/core.dart';

class PageableMessagesEntity {
  final List<MessageEntity> messages;
  final PageableResponse pageInfo;

  PageableMessagesEntity({
    required this.messages,
    required this.pageInfo,
  });
}
