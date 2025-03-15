import 'package:auth/auth.dart';
import 'package:chats/src/data/data_source/chat.dart';
import 'package:chats/src/data/mappers/pageable_chats.dart';
import 'package:chats/src/data/mappers/pageable_messages.dart';
import 'package:chats/src/domain/entity/chat/pageable_chat.dart';
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
      final res = await _dataSource.getChatsList(query.toModel(), userId);
      /// TODO: переделать когда, будет получен список пользователей
      final companions = await _usersDataSource.getUsers(
        query.toModel(),
        ['ab4c22b2-a577-4aef-91e1-c8a8be8851d9'],
      );
      return Right(res.toDomain(companions.content));
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
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
