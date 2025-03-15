import 'dart:async';

import 'package:auth/src/domain/entities/user/user.dart';
import 'package:auth/src/domain/repositories/user.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class GetUsersUseCase
    implements BaseUseCase<BaseError, List<UserEntity>, List<String>> {
  final UserRepositoryI _userRepository;

  static const _querySize = 20;

  var _page = 0;

  int? _maxPages;

  GetUsersUseCase(this._userRepository);

  @override
  Future<Either<BaseError, List<UserEntity>>> call(List<String> ids) async {
    final pageQuery = PageQuery(
      page: _page++,
      size: _querySize,
      sort: null,
    );
    final res = await _userRepository.getUsersInfo(pageQuery, ids);
    return res.fold(Left.new, (data) {
      _maxPages = data.pageInfo.totalPages;
      return Right(data.users);
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
