import 'dart:async';

import 'package:chats/src/data/data_source/chat.dart';
import 'package:chats/src/data/repository/chat.dart';
import 'package:chats/src/domain/entity/chat/chat.dart';
import 'package:chats/src/domain/entity/chat/page_query.dart';
import 'package:chats/src/domain/repository/chat.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class GetChatsUseCase
    implements BaseUseCase<BaseError, List<ChatEntity>, void> {
  static const _querySize = 20;

  var _page = 0;

  int? _maxPages;

  final String _userId;

  final ChatRepositoryI _chatRepository;

  GetChatsUseCase._(this._userId, this._chatRepository);

  factory GetChatsUseCase({
    required String userId,
  }) {
    return GetChatsUseCase._(
      userId,
      ChatRepository(
        ChatDataSource(),
      ),
    );
  }

  @override
  FutureOr<Either<BaseError, List<ChatEntity>>> call([_]) async {
    final pageQuery = PageQuery(
      page: _page++,
      size: _querySize,
      sort: null,
    );
    final res = await _chatRepository.getChats(pageQuery, _userId);
    return res.fold(Left.new, (data) {
      _maxPages = data.pageInfo.totalPages;
      return Right(data.chats);
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
