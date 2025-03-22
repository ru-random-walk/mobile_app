part of 'mettings_bloc.dart';

@immutable
sealed class MettingsState {}

final class MettingsLoading extends MettingsState {}

final class MettingsData extends MettingsState {
  final List<MeetingsForDayEntity> meetings;
  MettingsData({required this.meetings});
}

final class MettingsEmpty extends MettingsState {}

final class MettingsError extends MettingsState {
  final BaseError error;
  MettingsError({required this.error});
}
