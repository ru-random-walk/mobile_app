part of 'available_time_bloc.dart';

@immutable
sealed class AvailableTimeState {}

final class AvailableTimeCreatingLoading extends AvailableTimeState {}

final class AvailableTimeCreatingSuccess extends AvailableTimeState {}

final class AvailableTimeCreatingError extends AvailableTimeState {}

final class Idle extends AvailableTimeState {}

final class AvailableTimeUpdateSucces extends AvailableTimeState {
  final AvailableTimeModifyEntity entity;
  AvailableTimeUpdateSucces(this.entity);
}

final class AvailableTimeUpdateError extends AvailableTimeState {}
