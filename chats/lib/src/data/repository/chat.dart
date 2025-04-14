import 'package:auth/auth.dart';
import 'package:chats/src/data/data_source/chat.dart';
import 'package:chats/src/data/mappers/chat.dart';
import 'package:chats/src/data/mappers/pageable_messages.dart';
import 'package:chats/src/data/models/chat/chat.dart';
import 'package:chats/src/domain/entity/chat/chat.dart';
import 'package:chats/src/domain/entity/chat/pageable_chat.dart';
import 'package:chats/src/domain/entity/message/message.dart';
import 'package:chats/src/domain/entity/message/pageable_messages.dart';
import 'package:chats/src/domain/repository/chat.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class ChatRepository implements ChatRepositoryI {
  final ChatDataSource _dataSource;
  final UsersDataSource _usersDataSource;

  ChatRepository(this._dataSource, this._usersDataSource);

  @override
  Future<Either<BaseError, PageableChats>> getChats(
    PageQuery query,
    String userId,
  ) async {
    try {
      final List<ChatEntity> chats;
      final res = await _dataSource.getChatsList(query.toModel(), userId);
      if (res.isEmpty) {
        chats = [];
      } else {
        chats = await Future.wait(
          res.map((e) => _loadExtraDataForChat(e, userId)),
        );
      }
      return Right(
        PageableChats(
          chats: chats,
          pageInfo: PageableResponse(
            number: 0,
            size: 1,
            totalElements: 1,
            totalPages: 1,
          ),
        ),
      );
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }

  Future<ChatEntity> _loadExtraDataForChat(
      ChatModel chat, String userId) async {
    final companionId = chat.memberIds.firstWhere((id) => id != userId);
    final companionModel = await _usersDataSource
        .getUsers(PageQueryModel(page: 0, size: 1), [companionId]);
    final companionEntity = companionModel.content.first.toDomain();
    final lastMessage = await _getLastMessageInChat(chat.id, userId);
    return chat.toDomain(companionEntity, lastMessage);
  }

  Future<MessageEntity?> _getLastMessageInChat(
    String chatId,
    String currentUserId,
  ) async {
    final pageQuery = PageQueryModel(
      page: 0,
      size: 1,
      sort: [
        'sent_at',
        'desc',
      ],
    );
    final res = await _dataSource.getMessagesList(pageQuery, chatId);
    return res.toDomain(currentUserId).messages.firstOrNull;
  }

  @override
  Future<Either<BaseError, PageableMessagesEntity>> getMessages(
    PageQuery query,
    String currentUserId,
    String chatId,
  ) async {
    try {
      final res = await _dataSource.getMessagesList(query.toModel(), chatId);
      return Right(res.toDomain(currentUserId));
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }
}
