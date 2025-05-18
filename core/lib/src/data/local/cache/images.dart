import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheImagesDataSource {
  final cacheManager = DefaultCacheManager();

  Future<Uint8List> downloadImage(String url, String key) async {
    final res = await cacheManager.downloadFile(url, key: key);
    return res.file.readAsBytes();
  }

  Future<Uint8List?> getImageFromCache(String key) async {
    final res = await cacheManager.getFileFromCache(key);
    return res?.file.readAsBytes();
  }

  void dispose() => cacheManager.dispose();
}
