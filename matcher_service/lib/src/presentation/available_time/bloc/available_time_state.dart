part of 'available_time_bloc.dart';

@immutable
sealed class AvailableTimeState {}

final class AvailableTimeStateLoadingClubs extends AvailableTimeState {}

sealed class AvailableTimeStateClubsResult extends AvailableTimeState {
  final List<ShortClubEntity> clubs;
  AvailableTimeStateClubsResult(this.clubs);
}

final class AvailableTimeCreatingLoading extends AvailableTimeStateClubsResult {
  AvailableTimeCreatingLoading(super.clubs);
}

final class AvailableTimeCreatingSuccess extends AvailableTimeStateClubsResult {
  AvailableTimeCreatingSuccess(super.clubs);
}

final class AvailableTimeCreatingError extends AvailableTimeStateClubsResult {
  AvailableTimeCreatingError(super.clubs);
}

final class Idle extends AvailableTimeStateClubsResult {
  Idle(super.clubs);
}

final class AvailableTimeUpdateSucces extends AvailableTimeStateClubsResult {
  final AvailableTimeModifyEntity entity;
  AvailableTimeUpdateSucces(this.entity, super.clubs);
}

final class AvailableTimeUpdateError extends AvailableTimeStateClubsResult {
  AvailableTimeUpdateError(super.clubs);
}
