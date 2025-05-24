import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:meta/meta.dart';

part 'state.dart';

class CachedImageCubit<Arg extends GetObjectPhotoArgs>
    extends Cubit<CachedImageState> {
  final Arg getPhotoArg;

  final GetPhotoForObjectWithId _getClubPhoto;

  CachedImageCubit({
    required this.getPhotoArg,
    required GetPhotoForObjectWithId getClubPhoto,
  })  : _getClubPhoto = getClubPhoto,
        super(ClubPhotoLoading()) {
    _loadPhoto();
  }

  void _loadPhoto() async {
    final res = await _getClubPhoto(getPhotoArg);
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
