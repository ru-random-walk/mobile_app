import 'dart:async';

import 'package:core/core.dart';
import 'package:matcher_service/src/data/data_source/matcher.dart';
import 'package:matcher_service/src/data/mapper/person/schedule.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/list.dart';
import 'package:matcher_service/src/domain/repository/person.dart';
import 'package:utils/utils.dart';

class PersonRepository implements PersonRepositoryI {
  final MatcherDataSource _matcherDataSource;

  final _controller =
      StreamController<Either<BaseError, List<MeetingsForDayEntity>>>();

  @override
  Stream<Either<BaseError, List<MeetingsForDayEntity>>>
      get userScheduleStream => _controller.stream;

  PersonRepository(this._matcherDataSource);

  @override
  Future<void> loadUserSchedule() async {
    try {
      final res = await _matcherDataSource.getUserSchedule();
      final entities = res.map((e) => e.toEntity()).toList();
      _controller.add(Right(entities));
    } catch (e, s) {
      _controller.add(Left(BaseError(e.toString(), s)));
    }
  }
}
