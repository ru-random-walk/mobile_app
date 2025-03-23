import 'dart:async';

import 'package:core/core.dart';
import 'package:matcher_service/src/data/data_source/matcher.dart';
import 'package:utils/utils.dart';

import '../../../data/repository/available_time.dart';
import '../../entity/available_time/modify.dart';
import '../../repository/available_time.dart';

class AddAvailableTimeUseCase
    implements BaseUseCase<BaseError, void, AvailableTimeModifyEntity> {
  final AvailableTimeRepositoryI _repository;

  AddAvailableTimeUseCase._(this._repository);

  factory AddAvailableTimeUseCase() => AddAvailableTimeUseCase._(
        AvailableTimeRepository(
          MatcherDataSource(),
        ),
      );

  @override
  FutureOr<Either<BaseError, void>> call(
          AvailableTimeModifyEntity availabelTimeEntity) =>
      _repository.addAvailableTime(availabelTimeEntity);
}
