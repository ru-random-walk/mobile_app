import 'package:core/core.dart';
import 'package:utils/utils.dart';

abstract interface class RemoteImageInfoRepository {
  Future<Either<BaseError, String>> getObjectPhotoUrl(String objectId);
}
