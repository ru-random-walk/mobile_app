import 'package:matcher_service/src/data/mapper/person/schedule_time_frame.dart';
import 'package:matcher_service/src/data/model/schedule/user_schedule.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/entity.dart';

extension PersonScheduleMapper on UserScheduleModel {
  MeetingsForDayEntity toEntity() {
    return MeetingsForDayEntity(
      date: date,
      meetings: timeFrames.map((e) => e.toEntity()).toList(),
    );
  }
}
