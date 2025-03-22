import 'package:core/core.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/entity.dart';
import 'package:utils/utils.dart';

abstract interface class PersonRepositoryI {
  Future<Either<BaseError, List<MeetingsForDayEntity>>> getUserSchedule();
}
