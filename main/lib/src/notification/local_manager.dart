part of 'manager.dart';

/// Путь до иконки Android, которая будет отображаться в уведомлении
const _androidIconPath = 'ic_launcher';

/// Канал для уведомлений Android
const _androidChannel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.max,
);

/// Настройки инициализации Android
const _androidInitSettings = AndroidInitializationSettings(_androidIconPath);

/// Настройки инициализации для уведомлений
const _initSettings = InitializationSettings(
  android: _androidInitSettings,
);

/// Менеджер для отображения уведомлений вручную
///
/// В данный момент используется только для отображения уведомлений в
/// состоянии `Foreground` полученных на системе `Android`
///
class _LocalNotificationsManager {
  /// Плагин
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Коллбэк при нажатии на уведомление
  late final OnNotificationTap _onNotificationTap;

  _LocalNotificationsManager();

  /// Метод инициализации
  ///
  /// - Устанавливает коллбэк при нажатии на уведомление
  /// - Инициализрует нативные каналы
  /// - Иницализирует функцию по нажатию на уведомление
  ///
  Future<void> init(
    OnNotificationTap onNotificationTap,
  ) async {
    _onNotificationTap = onNotificationTap;
    if (UniversalPlatform.isWeb) {
      JsNotificationsPlatform.instance.tapStream.listen(
        (data) => _onNotificationTap(
          data.data ?? <String, dynamic>{},
        ),
      );
    }
    if (UniversalPlatform.isAndroid) {
      await _initNotificationsChannels();
      _init(_onForegroungMessageTap);
    }
  }

  /// Метод по нажатию на уведомление, полученное в состоянии `Foreground`
  ///
  /// Парсит доп. данные из уведомления, и при успешном парсинге вызывает
  /// функцию обработки этих доп. данных
  ///
  void _onForegroungMessageTap(NotificationResponse notificationResponse) {
    try {
      final payload = notificationResponse.payload;
      if (payload == null || payload.isEmpty) return;
      final data = jsonDecode(payload) as Map<String, dynamic>;
      _onNotificationTap(data);
    } catch (_) {}
  }

  /// Метод для инициализации платформенных каналов
  ///
  Future<void> _initNotificationsChannels() async {
    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidChannel);
  }

  /// Метод для отображения локального уведомления из уведомления [message],
  /// которое было получено от `Firebase`
  ///
  /// Используется только для `Android`
  ///
  void showNotification(RemoteMessage message) {
    log('Foreground message arrived: ${message.notification?.title}');
    if (UniversalPlatform.isWeb) {
      JsNotificationsPlatform.instance.showNotification(
        message.notification?.title ?? '',
        body: message.notification?.body,
        data: message.data,
      );
    }
    if (UniversalPlatform.isAndroid) {
      final notification = message.notification;
      final android = message.notification?.android;

      String? payload;

      try {
        payload = jsonEncode(message.data);
      } catch (_) {}

      if (notification != null && android != null) {
        _localNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: _androidIconPath,
            ),
          ),
          payload: payload,
        );
      }
    }
  }

  /// Иницализация настроек и коллбэка при нажатии
  void _init(DidReceiveNotificationResponseCallback onNotificationTap) {
    _localNotificationsPlugin.initialize(
      _initSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
    );
  }
}
