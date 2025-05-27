import 'package:core/core.dart';
import 'package:image_picker/image_picker.dart';

class UpdateUserAvatar extends SetObjectPhotoArgs {
  final XFile file;

  UpdateUserAvatar({
    required super.imageBytes,
    required super.objectId,
    required this.file,
  });
}
