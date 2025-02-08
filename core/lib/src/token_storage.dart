import 'package:auth/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class _TokenStorageKey {
  static const accessTokenKey = 'token';
  static const refreshTokenKey = 'refresh_token';
  static const tokenType = 'token_type';
}

class TokenStorage {
  static const _secureStorage = FlutterSecureStorage();

  static final _instance = TokenStorage._internal();

  factory TokenStorage() => _instance;

  TokenStorage._internal();

  Future<bool> updateData(TokenResponseEntity data) async {
    try {
      await _setToken(data.accessToken);
      await _setRefreshToken(data.refreshToken);
      await _setTokenType(data.tokenType);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<String?> getToken() =>
      _secureStorage.read(key: _TokenStorageKey.accessTokenKey);

  Future<void> _setToken(String token) =>
      _secureStorage.write(key: _TokenStorageKey.accessTokenKey, value: token);

  Future<void> removeToken() =>
      _secureStorage.delete(key: _TokenStorageKey.accessTokenKey);

  Future<String?> getRefreshToken() =>
      _secureStorage.read(key: _TokenStorageKey.refreshTokenKey);

  Future<void> _setRefreshToken(String token) =>
      _secureStorage.write(key: _TokenStorageKey.refreshTokenKey, value: token);

  Future<void> removeRefreshToken() =>
      _secureStorage.delete(key: _TokenStorageKey.refreshTokenKey);

  Future<String?> getTokenType() =>
      _secureStorage.read(key: _TokenStorageKey.tokenType);

  Future<void> _setTokenType(String token) =>
      _secureStorage.write(key: _TokenStorageKey.tokenType, value: token);

  Future<void> removeTokenType() =>
      _secureStorage.delete(key: _TokenStorageKey.tokenType);

  Future<void> clear() => _secureStorage.deleteAll();
}
