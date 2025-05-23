part of 'cubit.dart';

@immutable
sealed class CachedImageState {}

final class ClubPhotoLoading extends CachedImageState {}

final class ClubPhotoError extends CachedImageState {}

final class ClubPhotoData extends CachedImageState {
  final Uint8List file;

  ClubPhotoData(this.file);
}

final class ClubPhotoEmpty extends CachedImageState {}