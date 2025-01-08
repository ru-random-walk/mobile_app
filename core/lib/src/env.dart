import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentVariables {
  static final _instance = EnvironmentVariables._();

  EnvironmentVariables._();

  factory EnvironmentVariables() => _instance;

  static const _fileName = 'auth.env';
  static const _authCredentialsKey = 'USERNAME_AND_PASSWORD';
  static const _yandexGeocoderApiKey = 'YANDEX_GEOCODER_API_KEY';

  String? _yandexGeocoderApiKeyValue;

  static Future<void> load() => dotenv.load(fileName: _fileName);

  String? get authCredentials => dotenv.env[_authCredentialsKey];

  String get yandexGeocoderApiKey {
    _yandexGeocoderApiKeyValue ??= dotenv.env[_yandexGeocoderApiKey] ?? '';
    return _yandexGeocoderApiKeyValue!;
  }
}