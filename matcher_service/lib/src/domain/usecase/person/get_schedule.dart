import 'dart:async';

import 'package:core/core.dart';
import 'package:matcher_service/src/data/data_source/matcher.dart';
import 'package:matcher_service/src/data/repository/person.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/list.dart';
import 'package:matcher_service/src/domain/repository/person.dart';
import 'package:utils/utils.dart';

class GetScheduleUseCase
    implements BaseUseCase<BaseError, List<MeetingsForDayEntity>, void> {
  final PersonRepositoryI _personRepository;

  GetScheduleUseCase._(this._personRepository);

  factory GetScheduleUseCase() => GetScheduleUseCase._(
        PersonRepository(
          MatcherDataSource(),
        ),
      );

  @override
  Future<Either<BaseError, List<MeetingsForDayEntity>>> call([_]) =>
      _personRepository.getUserSchedule();
}
