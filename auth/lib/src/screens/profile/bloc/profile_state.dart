part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileData extends ProfileState {
  final DetailedUserEntity user;

  ProfileData({required this.user});
}

final class ProfileError extends ProfileState {
  final BaseError error;

  ProfileError({required this.error});
}

final class ProfileInvalidRefreshToken extends ProfileState {}
