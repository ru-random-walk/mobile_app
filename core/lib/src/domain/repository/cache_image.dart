import 'dart:typed_data';

abstract interface class CacheImageRepository {
  Future<Uint8List> downloadImage(String url, String objectId);

  Future<void> saveImage(Uint8List bytes, String objectId);

  Future<Uint8List?> getImageFromCache(String objectId);
}