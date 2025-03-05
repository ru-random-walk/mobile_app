import 'package:chats/src/domain/entity/chat/chat.dart';
import 'package:chats/src/domain/entity/chat/page_response.dart';

class PageableChats {
  final List<ChatEntity> chats;
  final PageableResponse pageInfo;

  PageableChats({
    required this.chats,
    required this.pageInfo,
  });
}
