import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'state.dart';

class CachedImageCubit extends Cubit<CachedImageState> {
  final String objectId;
  final int photoVersion;

  final GetPhotoForObjectWithId _getClubPhoto;

  CachedImageCubit({
    required this.objectId,
    required this.photoVersion,
    required GetPhotoForObjectWithId getClubPhoto,
  })  : _getClubPhoto = getClubPhoto,
        super(ClubPhotoLoading()) {
    _loadPhoto();
  }

  void _loadPhoto() async {
    final res = await _getClubPhoto(
      GetObjectPhotoArgs(
        objectId: objectId,
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
