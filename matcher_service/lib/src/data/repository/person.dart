import 'package:core/core.dart';
import 'package:matcher_service/src/data/data_source/matcher.dart';
import 'package:matcher_service/src/data/mapper/person/schedule.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/entity.dart';
import 'package:matcher_service/src/domain/repository/person.dart';
import 'package:utils/utils.dart';

class PersonRepository implements PersonRepositoryI {
  final MatcherDataSource _matcherDataSource;

  PersonRepository(this._matcherDataSource);

  @override
  Future<Either<BaseError, List<MeetingsForDayEntity>>>
      getUserSchedule() async {
    try {
      final res = await _matcherDataSource.getUserSchedule();
      return Right(res.map((e) => e.toEntity()).toList());
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }
}
