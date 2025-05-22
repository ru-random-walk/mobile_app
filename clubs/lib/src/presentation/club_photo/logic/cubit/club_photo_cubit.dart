import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:clubs/src/domain/usecase/get_club_photo.dart';
import 'package:meta/meta.dart';

part 'club_photo_state.dart';

class ClubPhotoCubit extends Cubit<ClubPhotoState> {
  final String clubId;
  final int photoVersion;

  final GetClubPhotoUseCase _getClubPhoto;

  ClubPhotoCubit({
    required this.clubId,
    required this.photoVersion,
    required GetClubPhotoUseCase getClubPhoto,
  })  : _getClubPhoto = getClubPhoto,
        super(ClubPhotoLoading()) {
    _loadPhoto();
  }

  void _loadPhoto() async {
    final res = await _getClubPhoto(
      GetClubPhotoArgs(
        clubId: clubId,
        photoVersion: photoVersion,
      ),
    );
    res.fold(
      (err) {
        if (err is EmptyPhotoError) {
          emit(ClubPhotoEmpty());
        } else {
          emit(ClubPhotoError());
        }
      },
      (bytes) => emit(
        ClubPhotoData(bytes),
      ),
    );
  }
}
