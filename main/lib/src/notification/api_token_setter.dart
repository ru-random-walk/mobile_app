part of 'manager.dart';

const _path = '/twitter/device';
const _addTokenPath = '$_path/add';
const _updateTokenPath = '$_path/refresh';

class _ApiTokenSetter {
  final dio = NetworkConfig.instance.dio;

  Future<bool> setNewToken(String token) async {
    try {
      final data = {
        'token': token,
      };
      final req = dio.post(_addTokenPath, data: data);
      final res = await req;
      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateToken(String oldToken, String token) async {
    try {
      final data = {
        'previousToken': oldToken,
        'newToken': token,
      };
      final req = dio.put(_updateTokenPath, data: data);
      final res = await req;
      return res.statusCode == 200;
    } catch (e) {
      Logger().e(
        'Failed to update push token with oldToken $oldToken and newToken $token',
      );
      return false;
    }
  }
}
