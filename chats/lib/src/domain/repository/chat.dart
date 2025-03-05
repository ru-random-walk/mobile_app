import 'package:chats/src/domain/entity/chat/page_query.dart';
import 'package:chats/src/domain/entity/chat/pageable_chat.dart';
import 'package:chats/src/domain/entity/message/pageable_messages.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

abstract interface class ChatRepositoryI {
  Future<Either<BaseError, PageableChats>> getChats(
    PageQuery query,
    String userId,
  );

  Future<Either<BaseError, PageableMessagesEntity>> getMessages(
    PageQuery query,
    String currentUserId,
    String chatId,
  );
}
