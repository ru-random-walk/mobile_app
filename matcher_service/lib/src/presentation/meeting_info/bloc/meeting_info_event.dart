part of 'meeting_info_bloc.dart';

@immutable
sealed class MeetingInfoEvent {}

class LoadAppointmentInfo extends MeetingInfoEvent {}

class UpdateAvailableTime extends MeetingInfoEvent {
  final AvailableTimeModifyEntity updateEntity;

  UpdateAvailableTime(this.updateEntity);
}

class DeleteMeeting extends MeetingInfoEvent {}
