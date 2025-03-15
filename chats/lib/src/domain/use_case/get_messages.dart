import 'dart:async';

import 'package:auth/auth.dart';
import 'package:chats/src/data/data_source/chat.dart';
import 'package:chats/src/data/repository/chat.dart';
import 'package:chats/src/domain/entity/message/message.dart';
import 'package:chats/src/domain/repository/chat.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class GetMessagesUseCase
    implements BaseUseCase<BaseError, List<MessageEntity>, void> {
  static const _querySize = 20;

  var _page = 0;

  int? _maxPages;

  final String _userId;

  final String _chatId;

  final ChatRepositoryI _chatRepository;

  GetMessagesUseCase._(
    this._userId,
    this._chatId,
    this._chatRepository,
  );

  factory GetMessagesUseCase({
    required String currentUserId,
    required String chatId,
  }) {
    return GetMessagesUseCase._(
      currentUserId,
      chatId,
      ChatRepository(
        ChatDataSource(),
        UsersDataSource(),
      ),
    );
  }

  @override
  FutureOr<Either<BaseError, List<MessageEntity>>> call([_]) async {
    final pageQuery = PageQuery(
      page: _page++,
      size: _querySize,
      sort: null,
    );
    final res = await _chatRepository.getMessages(
      pageQuery,
      _userId,
      _chatId,
    );
    return res.fold(Left.new, (data) {
      _maxPages = data.pageInfo.totalPages;
      return Right(data.messages);
    });
  }

  bool get allPagesLoaded {
    final maxPages = _maxPages;
    if (maxPages == null) return false;
    return _page >= maxPages;
  }

  void reset() {
    _page = 0;
    _maxPages = null;
  }
}
