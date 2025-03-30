import 'dart:async';

import 'package:core/core.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/list.dart';
import 'package:matcher_service/src/domain/repository/person.dart';
import 'package:utils/utils.dart';

class GetScheduleUseCase implements BaseUseCase<void, void, void> {
  final PersonRepositoryI _personRepository;

  GetScheduleUseCase(this._personRepository);

  Stream<Either<BaseError, List<MeetingsForDayEntity>>>
      get userScheduleStream => _personRepository.userScheduleStream;

  @override
  Future<Either<void, void>> call([_]) async {
    await _personRepository.loadUserSchedule();
    return Right<void, void>(null);
  }
}
