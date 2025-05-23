import 'package:core/core.dart';

const _cacheKeyArea = 'user_avatars/';

class AvatarCacheRepository extends CacheImageRepositoryI {
  AvatarCacheRepository() : super(_cacheKeyArea);
}
