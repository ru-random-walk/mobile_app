import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'club_photo_state.dart';

class ClubPhotoCubit extends Cubit<ClubPhotoState> {
  ClubPhotoCubit() : super(ClubPhotoLoading());

  void _loadPhoto() {
    
  }
}
