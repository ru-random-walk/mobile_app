import 'package:image_picker/image_picker.dart';

class ImagePickerDataSource {
  final _picker = ImagePicker();

  Future<XFile?> pickImage() => _picker.pickImage(source: ImageSource.gallery);
}
