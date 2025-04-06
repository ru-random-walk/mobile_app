import 'package:auth/auth.dart';
import 'package:chats/src/data/data_source/chat.dart';
import 'package:chats/src/data/mappers/chat.dart';
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
      final companionsIds =
          res.first.memberIds.firstWhere((id) => id != userId);
      final companion = (await _usersDataSource.getUsers(
        query.toModel(),
        [companionsIds],
      ))
          .content
          .first
          .toDomain();
      final result = res.map((e) => e.toDomain(companion)).toList();
      return Right(
        PageableChats(
          chats: result,
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
