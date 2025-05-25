part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ProfileLoadEvent extends ProfileEvent {}

class _UnauthorizeEvent extends ProfileEvent {}

class ProfileUpdatedEvent extends ProfileEvent {
  final DetailedUserEntity user;

  ProfileUpdatedEvent({required this.user});
}
