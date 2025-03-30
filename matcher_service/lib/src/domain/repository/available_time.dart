import 'package:core/core.dart';
import 'package:utils/utils.dart';

import '../entity/available_time/modify.dart';

abstract interface class AvailableTimeRepositoryI {
  Future<Either<BaseError, void>> addAvailableTime(
    AvailableTimeModifyEntity availabelTimeEntity,
  );

  Future<Either<BaseError, void>> updateAvailableTime(
    String id,
    AvailableTimeModifyEntity availabelTimeEntity,
  );

  Future<Either<BaseError, void>> deleteAvailableTime(
    String id,
  );
}
