import 'package:core/src/domain/enitites/image_info.dart';

abstract interface class LocalImageInfoRepository {
  Future<LocalImageInfo?> getImageInfo(String objectId);

  Future<void> saveImageInfo(LocalImageInfo imageInfo);
}
