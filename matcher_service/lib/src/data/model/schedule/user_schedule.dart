import 'package:json_annotation/json_annotation.dart';
import 'package:matcher_service/src/data/model/schedule/schedule_time_frame.dart';

part 'user_schedule.g.dart';

@JsonSerializable()
class UserScheduleModel {
  final DateTime date;
  final String timezone;
  final int walkCount;
  final List<ScheduleTimeFrameModel> timeFrames;

  UserScheduleModel({
    required this.date,
    required this.timezone,
    required this.walkCount,
    required this.timeFrames,
  });

  factory UserScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$UserScheduleModelFromJson(json);
}
