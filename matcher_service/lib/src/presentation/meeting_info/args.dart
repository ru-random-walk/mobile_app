import 'package:matcher_service/src/domain/entity/meeting_info/base.dart';

sealed class MeetingInfoArgs {}

class AppointmentIdArgs extends MeetingInfoArgs {
  final String id;

  AppointmentIdArgs(this.id);
}

class AvailableTimeInfoArgs extends MeetingInfoArgs {
  final AvailableTimeEntity availableTime;

  AvailableTimeInfoArgs(this.availableTime);
}
