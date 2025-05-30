// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:clubs/src/data/image/compressor.dart';
import 'package:clubs/src/data/image/picker.dart';
import 'package:core/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:utils/utils.dart';

const serverImageMaxSize = 1024 * 1024;
const localImageMaxSize = serverImageMaxSize * 5;

class TooBigImageError extends BaseError {
  TooBigImageError() : super('Image is too big', StackTrace.current);
}

class ImageNotPickedError extends BaseError {
  ImageNotPickedError() : super('No image picked', StackTrace.current);
}

class ImagePickerRepository {
  final _compressor = ImageCompressor();
  final _picker = ImagePickerDataSource();

  Future<Either<BaseError, XFile>> getImage() async {
    try {
      final image = await _picker.pickImage();
      if (image == null) {
        return Left(ImageNotPickedError());
      }
      final imageSize = await image.length();
      if (imageSize > localImageMaxSize) {
        return Left(TooBigImageError());
      } else if (imageSize > serverImageMaxSize) {
        final ratio = (imageSize / serverImageMaxSize).ceilToDouble();
        final compressedImage = await _compressor.testComporessList(
          await image.readAsBytes(),
          (100 / ratio).floor(),
        );
        return Right(
          XFile.fromData(
            compressedImage,
            name: image.name,
            path: image.path,
            mimeType: image.mimeType,
          ),
        );
      } else {
        return Right(
          XFile.fromData(
            await image.readAsBytes(),
            name: image.name,
            path: image.path,
            mimeType: image.mimeType,
          ),
        );
      }
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }
}
