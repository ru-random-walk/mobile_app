import 'package:core/core.dart';
import 'package:utils/utils.dart';

abstract interface class AvailableTimeRepositoryI {
  Future<Either<BaseError, void>> addAvailableTime();

  Future<Either<BaseError, void>> updateAvailableTime();

  Future<Either<BaseError, void>> deleteAvailableTime(int id);
}
