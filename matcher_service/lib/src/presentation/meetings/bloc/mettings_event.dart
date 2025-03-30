part of 'mettings_bloc.dart';

@immutable
sealed class MettingsEvent {}

class GetMettingsEvent extends MettingsEvent {}

class _MeetingsDataArrivedEvent extends MettingsEvent {
  final Either<BaseError, List<MeetingsForDayEntity>> data;

  _MeetingsDataArrivedEvent(this.data);
}
