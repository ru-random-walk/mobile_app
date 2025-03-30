import 'dart:async';

import 'package:core/core.dart';
import 'package:matcher_service/src/data/data_source/matcher.dart';
import 'package:matcher_service/src/domain/repository/person.dart';
import 'package:utils/utils.dart';

import '../../../data/repository/available_time.dart';
import '../../entity/available_time/modify.dart';
import '../../repository/available_time.dart';

class AddAvailableTimeUseCase
    implements BaseUseCase<BaseError, void, AvailableTimeModifyEntity> {
  final AvailableTimeRepositoryI _repository;
  final PersonRepositoryI _personRepository;

  AddAvailableTimeUseCase._(this._repository, this._personRepository);

  factory AddAvailableTimeUseCase(PersonRepositoryI personRepository) =>
      AddAvailableTimeUseCase._(
        AvailableTimeRepository(
          MatcherDataSource(),
        ),
        personRepository,
      );

  @override
  FutureOr<Either<BaseError, void>> call(
      AvailableTimeModifyEntity availabelTimeEntity) async {
    final res = await _repository.addAvailableTime(availabelTimeEntity);
    if (res.isRight) _personRepository.loadUserSchedule();
    return res;
  }
}
