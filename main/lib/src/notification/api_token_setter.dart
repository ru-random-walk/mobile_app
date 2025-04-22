part of 'manager.dart';

class _ApiTokenSetter {
  final dio = NetworkConfig.instance.dio;

  Future<bool> setNewToken(String token) =>
      _setNewToken('/twitter/device/add', token, false);

  Future<bool> updateToken(String token) =>
      _setNewToken('/twitter/device/refresh', token, true);

  Future<bool> _setNewToken(String path, String token, bool isUpdating) async {
    try {
      final data = {
        'token': token,
      };
      final req =
          isUpdating ? dio.put(path, data: data) : dio.post(path, data: data);
      final res = await req;
      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
