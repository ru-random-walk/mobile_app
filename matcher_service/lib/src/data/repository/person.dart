import 'dart:async';

import 'package:clubs/clubs.dart';
import 'package:core/core.dart';
import 'package:matcher_service/src/data/data_source/matcher.dart';
import 'package:matcher_service/src/data/mapper/person/schedule.dart';
import 'package:matcher_service/src/data/mapper/person/schedule_time_frame.dart';
import 'package:matcher_service/src/data/model/schedule/schedule_time_frame.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/list.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/preview.dart';
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
      final entities = res.map((e) => e.toEntity(_map)).toList();
      final awaitedEntities = await Future.wait(entities);
      _controller.add(Right(awaitedEntities));
    } catch (e, s) {
      _controller.add(Left(BaseError(e.toString(), s)));
    }
  }

  Future<List<MeetingPreviewInfoEntity>> _map(
    List<ScheduleTimeFrameModel> timeFrames,
    DateTime date,
  ) {
    return Future.wait(
      timeFrames.map((timeFrame) => _mapOne(timeFrame, date)).toList(),
    );
  }

  Future<MeetingPreviewInfoEntity> _mapOne(
    ScheduleTimeFrameModel timeFrame,
    DateTime date,
  ) async {
    final availableTimeId = timeFrame.availableTimeId;
    if (availableTimeId == null) {
      return timeFrame.toEntity(date, []);
    } else {
      final clubs = await Future.wait(
        timeFrame.availableTimeClubsInFilter
                ?.map((e) => getClubInfoById(e))
                .toList() ??
            <Future<ShortClubEntity>>[],
      );
      return timeFrame.toEntity(date, clubs);
    }
  }

  @override
  Future<Either<BaseError, List<ShortClubEntity>>> getCurrentUserClubs(
    String userId,
  ) async {
    try {
      final res = await getUserClubs(
        userId: userId,
        apiService: ClubApiService(),
      );
      final clubsMapsList = (res!['data']['getUserClubsWithRole'] as List)
          .cast<Map<String, dynamic>>();
      final clubs = clubsMapsList
          .map(
            (e) => ShortClubEntity(
              id: e['club']['id'] as String,
              name: e['club']['name'] as String,
            ),
          )
          .toList();
      return Right(clubs);
      // return Right(
      //   clubsMapsList.map((e) => ShortClubEntity()).toList(),
      // );
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }

  Future<ShortClubEntity> getClubInfoById(String id) async {
    final res = await getClubInfo(clubId: id, apiService: ClubApiService());
    final data = res!['data']['getClub'];
    return ShortClubEntity(
      id: data!['id'],
      name: data['name'],
    );
  }
}
