import 'package:core/core.dart';
import 'package:matcher_service/src/data/mapper/available_time.dart';
import 'package:utils/utils.dart';

import '../../domain/entity/available_time/modify.dart';
import '../../domain/repository/available_time.dart';
import '../data_source/matcher.dart';

class AvailableTimeRepository implements AvailableTimeRepositoryI {
  final MatcherDataSource _matcherDataSource;

  AvailableTimeRepository(this._matcherDataSource);

  @override
  Future<Either<BaseError, void>> addAvailableTime(
    AvailableTimeModifyEntity availabelTimeEntity,
  ) async {
    try {
      final availabelTimeModel = availabelTimeEntity.toModel();
      final res = await _matcherDataSource.addAvailableTime(availabelTimeModel);
      if (res.response.statusCode == 200) {
        return Right(null);
      } else {
        return Left(BaseError(res.response.data, null));
      }
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }

  @override
  Future<Either<BaseError, void>> deleteAvailableTime(
    String id,
  ) async {
    try {
      final res = await _matcherDataSource.deleteAvailableTime(id);
      if (res.response.statusCode == 200) {
        return Right(null);
      } else {
        return Left(BaseError(res.response.data, null));
      }
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }

  @override
  Future<Either<BaseError, void>> updateAvailableTime(
    String id,
    AvailableTimeModifyEntity availabelTimeEntity,
  ) async {
    try {
      final availabelTimeModel = availabelTimeEntity.toModel();
      final res =
          await _matcherDataSource.updateAvailableTime(id, availabelTimeModel);
      if (res.response.statusCode == 200) {
        return Right(null);
      } else {
        return Left(BaseError(res.response.data, null));
      }
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }
}
