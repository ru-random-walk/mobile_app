import 'package:clubs/clubs.dart';
import 'package:core/core.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/list.dart';
import 'package:utils/utils.dart';

abstract interface class PersonRepositoryI {
  Stream<Either<BaseError, List<MeetingsForDayEntity>>> get userScheduleStream;

  Future<void> loadUserSchedule();

  Future<Either<BaseError, List<ShortClubEntity>>> getCurrentUserClubs(String userId);
}
