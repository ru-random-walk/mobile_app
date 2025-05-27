part of 'available_time_bloc.dart';

sealed class AvailableTimeEvent {}

final class AvailableTimeAdd extends AvailableTimeEvent {
  final AvailableTimeModifyEntity availabelTime;

  AvailableTimeAdd(this.availabelTime);
}

final class _LoadPersonClubsEvent extends AvailableTimeEvent {}
