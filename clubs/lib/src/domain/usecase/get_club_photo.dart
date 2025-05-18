import 'dart:async';
import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:utils/utils.dart';

class GetClubPhotoArgs {
  final String clubId;
  final int photoVersion;

  GetClubPhotoArgs({
    required this.clubId,
    required this.photoVersion,
  });
}

class GetClubPhotoUseCase
    implements BaseUseCase<BaseError, Uint8List, GetClubPhotoArgs> {
  // final ClubPhotoDataSource clubPhotoDataSource;


  @override
  FutureOr<Either<BaseError, Uint8List>> call(GetClubPhotoArgs params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
