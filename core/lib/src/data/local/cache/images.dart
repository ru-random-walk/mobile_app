import 'dart:developer';
import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheImageRepositoryI implements CacheImageRepository {
  final String _cacheKeyArea;

  final cacheManager = DefaultCacheManager();

  CacheImageRepositoryI(String cacheKeyArea) : _cacheKeyArea = cacheKeyArea;

  @override
  Future<Uint8List> downloadImage(String url, String key) async {
    final res = await cacheManager.downloadFile(url, key: _getKey(key));
    log('Photo cached for ${_getKey(key)} is ${res.file.path}');
    return res.file.readAsBytes();
  }

  @override
  Future<void> saveImage(Uint8List bytes, String key) async {
    await cacheManager.putFile(_getKey(key), bytes);
  }

  @override
  Future<Uint8List?> getImageFromCache(String key) async {
    final res = await cacheManager.getFileFromCache(_getKey(key));
    log('Photo got from cache for ${_getKey(key)} is ${res?.file.path}');
    return res?.file.readAsBytes();
  }

  String _getKey(String objectId) => _cacheKeyArea + objectId;

  void dispose() => cacheManager.dispose();
}
