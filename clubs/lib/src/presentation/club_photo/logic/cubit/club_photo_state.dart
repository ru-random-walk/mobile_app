part of 'club_photo_cubit.dart';

@immutable
sealed class ClubPhotoState {}

final class ClubPhotoLoading extends ClubPhotoState {}

final class ClubPhotoError extends ClubPhotoState {}

final class ClubPhotoData extends ClubPhotoState {
  final Uint8List file;

  ClubPhotoData(this.file);
}
