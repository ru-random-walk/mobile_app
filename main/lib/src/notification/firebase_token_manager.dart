part of 'manager.dart';

const _fcmTokenKey = 'fcmToken';

/// Менеджер по работе с токеном Firebase
///
class _FirebaseTokenManager {
  /// Модель для работы с уведомлениями
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Менеджер для SharedPreferences
  late final SharedPreferences _sharedPrefs;

  final tokenSender = _ApiTokenSetter();

  _FirebaseTokenManager();

  /// Функция инициализации
  ///
  /// - Инициализирует пуш токен
  /// - Подписывается на рефреш токена
  ///
  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
    await _initToken();
    _initListeningToNewToken();
  }

  String? get _cachedToken => _sharedPrefs.getString(_fcmTokenKey);

  Future<void> _setNewToken(String token) =>
      _sharedPrefs.setString(_fcmTokenKey, token);

  /// Записан ли токен локально
  bool get _isTokenInitialized => _cachedToken != null;

  /// Получение нового токена
  Future<String?> get _newToken async {
    final newToken = await _messaging.getToken();
    log('FCM token: $newToken');
    return newToken;
  }

  /// Проверка актуальности локально сохраненного токена
  Future<bool> _checkTokenRelevance(String newToken) async {
    final lastToken = _cachedToken;
    if (lastToken == null) return false;
    return lastToken == newToken;
  }

  Future<bool> updateTokenOnServer(String oldToken, String newToken) =>
      tokenSender.updateToken(oldToken, newToken);

  Future<bool> setNewTokenOnServer(String token) => tokenSender.setNewToken(token);

  /// Иницализация токена при самом первом запуске приложения
  Future<void> _initTokenOnVeryFirstLaunch() async {
    final token = await _newToken;
    if (token == null) return;
    final sended = await setNewTokenOnServer(token);
    if (sended) {
      _setNewToken(token);
    }
  }

  /// Метод для обновления токена
  ///
  /// - Обновляет данные о токене на сервере
  /// - В случае успешной отправки на сервер, обновляет локальное
  /// значение токена
  ///
  Future<void> _updateToken(
    String oldToken,
    String newToken,
  ) async {
    final sended = await updateTokenOnServer(oldToken, newToken);
    if (sended) {
      await _setNewToken(newToken);
    }
  }

  /// Функция для обновления токена, если он уже протух
  Future<void> _checkIfTokenNeedToBeRefreshed() async {
    final newToken = await _newToken;
    if (newToken == null) return;
    final isRelevant = await _checkTokenRelevance(newToken);
    if (isRelevant) return;
    final oldToken = _cachedToken;
    if (oldToken == null) return;
    await _updateToken(oldToken, newToken);
  }

  /// Метод для иницаилизации токена
  ///
  /// - Если токен уже существует обновляем его локально при необходимости
  /// - Если токена еще нет, инициализируем его с нуля
  ///
  Future<void> _initToken() async {
    if (_isTokenInitialized) {
      await _checkIfTokenNeedToBeRefreshed();
    } else {
      await _initTokenOnVeryFirstLaunch();
    }
  }

  /// Метод для прослушивания получения нового токена
  void _initListeningToNewToken() {
    _messaging.onTokenRefresh.listen((newToken) {
      final oldToken = _cachedToken;
      if (oldToken == null) return;
      _updateToken(oldToken, newToken);
    });
  }
}
