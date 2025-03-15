import 'package:core/core.dart';
import 'package:utils/utils.dart';

import '../entity/available_time.dart';

abstract interface class AvailableTimeRepositoryI {
  Future<Either<BaseError, void>> addAvailableTime(AvailableTimeEntity availabelTimeEntity);

  Future<Either<BaseError, void>> updateAvailableTime();

  Future<Either<BaseError, void>> deleteAvailableTime(int id);
}
