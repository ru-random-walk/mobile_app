part of 'available_time_bloc.dart';

@immutable
sealed class AvailableTimeState {}

final class AvailableTimeCreatingLoading extends AvailableTimeState {}

final class AvailableTimeCreatingSuccess extends AvailableTimeState {}

final class AvailableTimeCreatingError extends AvailableTimeState {}

final class Idle extends AvailableTimeState {}
