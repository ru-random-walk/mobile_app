import 'dart:async';

import 'package:matcher_service/src/data/model/schedule/schedule_time_frame.dart';
import 'package:matcher_service/src/data/model/schedule/user_schedule.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/list.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/preview.dart';

extension PersonScheduleMapper on UserScheduleModel {
  Future<MeetingsForDayEntity> toEntity(
    FutureOr<List<MeetingPreviewInfoEntity>> Function(
      List<ScheduleTimeFrameModel> timeFrame,
      DateTime date,
    ) mapper,
  ) async {
    final res = await mapper(timeFrames, date);
    return MeetingsForDayEntity(
      date: date,
      meetings: res..sort((e1, e2) => e1.timeStart.compareTo(e2.timeStart)),
    );
  }
}
