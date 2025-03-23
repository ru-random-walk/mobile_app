part of 'meeting_info_bloc.dart';

@immutable
sealed class MeetingInfoState {}

final class AppointmentInfoLoading extends MeetingInfoState {}

final class AppointmentInfoSuccess extends MeetingInfoState {
  final AppointmentEntity appointment;

  AppointmentInfoSuccess(this.appointment);
}

final class AppointmentInfoError extends MeetingInfoState {}

final class AvailableTimeInfo extends MeetingInfoState {
  final AvailableTimeEntity availableTime;

  AvailableTimeInfo(this.availableTime);
}
