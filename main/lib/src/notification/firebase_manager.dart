part of 'manager.dart';

/// Коллбэк при нажатии на пуш-уведомление
typedef OnNewRemoteMessage = void Function(RemoteMessage message);

/// Мендежер для управления пуш уведомлений, которые приходят нам
/// через Firebase
///
class _FirebaseNotificationsManager {
  /// Модель для работы с уведомлениями
  final _messaging = FirebaseMessaging.instance;

  /// Коллбэк при нажатии на пуш-уведомление
  late final OnNotificationTap _onNotificationTap;

  _FirebaseNotificationsManager();

  /// Метод инициализации
  ///
  /// - Устанавливает коллбэк при нажатии на пуш
  /// - Запрашивает разрещение на отправку уведомлений
  /// - Проверяет, не было ли приложение открыто из `Terminated` состояния
  /// - Подписывается на уведомления, получаемые в состоянии `Foreground`
  ///
  Future<void> init({
    required OnNewRemoteMessage onNewMessageInForeground,
    required OnNotificationTap onNotificationTap,
  }) async {
    _onNotificationTap = onNotificationTap;
    await _requestPermissions();
    await _checkIfAppOpenedFromTerminatedState();
    _initListenToTapNotificationFromBackgrond();
    _listenToNewMessage(onNewMessageInForeground);
  }

  /// Метод для подписки на уведомления, получаемые в состоянии `Foreground`
  void _listenToNewMessage(OnNewRemoteMessage onNewMessage) {
    FirebaseMessaging.onMessage.listen((msg) {
      onNewMessage(msg);
      log('FCM Message arrived: ${msg.data}');
    });
  }

  /// Запрашивает разрешение на отправку уведомлений
  ///
  /// Также устанавливает параметры для показа уведомления в состоянии
  /// `Foreground` для iOS
  ///
  Future<void> _requestPermissions() async {
    await _messaging.requestPermission();
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// Метод, который проверяет, было ли открыто приложение путем нажатия
  /// на уведомление из состояния `Terminated`
  ///
  /// Если да - то обязательно должен быть `initialMessage`, который мы получаем
  /// с помощью метода `_messaging.getInitialMessage` и дальше его обрабатываем
  ///
  /// Если полученный `initialMessage == null`, то это запуск приложения не
  /// через нажатие на пуш, ничего делать не требуется
  ///
  Future<void> _checkIfAppOpenedFromTerminatedState() async {
    final message = await _messaging.getInitialMessage();
    if (message != null) _onFirebaseNotificationTap(message);
  }

  /// Функция, вызываемая при нажатии на уведомление
  void _onFirebaseNotificationTap(RemoteMessage message) {
    final data = message.data;
    _onNotificationTap(data);
  }

  /// Инициализация прослушивания нажатия на уведомления в состоянии
  /// `Background` на обоих платформах
  ///
  /// Также обрабатывает нажатие на уведомление в состоянии `Foreground`
  /// для `iOS`
  ///
  void _initListenToTapNotificationFromBackgrond() {
    if (UniversalPlatform.isAndroid) {
      FirebaseMessaging.onMessageOpenedApp.listen(_onFirebaseNotificationTap);
    } else if (UniversalPlatform.isWeb) {
      window.onMessage.listen(
        (msg) {
          try {
          Logger().i('Window Message with type: ${msg.type}');
          final data = jsonDecode(msg.data.toString()) as Map<String, dynamic>;
          Logger().i('Window Message data: $data');
          _onNotificationTap(data);
          } catch (e) {
            Logger().e(e.toString());
          }
        },
      );
    }
  }
}
