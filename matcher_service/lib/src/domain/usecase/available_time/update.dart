import 'dart:async';

import 'package:core/core.dart';
import 'package:matcher_service/src/data/data_source/matcher.dart';
import 'package:matcher_service/src/data/repository/available_time.dart';
import 'package:matcher_service/src/domain/entity/available_time/modify.dart';
import 'package:matcher_service/src/domain/repository/available_time.dart';
import 'package:matcher_service/src/domain/repository/person.dart';
import 'package:utils/utils.dart';

class UpdateAvailableTimeArgs {
  final String id;
  final AvailableTimeModifyEntity modifyEntity;

  UpdateAvailableTimeArgs({
    required this.id,
    required this.modifyEntity,
  });
}

class UpdateAvailableTimeUseCase
    implements BaseUseCase<BaseError, void, UpdateAvailableTimeArgs> {
  final AvailableTimeRepositoryI _repository;
  final PersonRepositoryI _personRepository;

  UpdateAvailableTimeUseCase._(
    this._repository,
    this._personRepository,
  );

  factory UpdateAvailableTimeUseCase(
    PersonRepositoryI personRepository,
  ) =>
      UpdateAvailableTimeUseCase._(
        AvailableTimeRepository(MatcherDataSource()),
        personRepository,
      );

  @override
  Future<Either<BaseError, void>> call(UpdateAvailableTimeArgs params) async {
    final res = await _repository.updateAvailableTime(
      params.id,
      params.modifyEntity,
    );
    if (res.isRight) _personRepository.loadUserSchedule();
    return res;
  }
}
