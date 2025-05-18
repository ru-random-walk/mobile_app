import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:core/core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'push_data/push_data.dart';

part 'firebase_manager.dart';
part 'firebase_token_manager.dart';
part 'local_manager.dart';
part 'api_token_setter.dart';

/// Функция при нажатии на уведомление
typedef OnNotificationTap = void Function(Map<String, dynamic>);

/// Менджер для работы с уведомлениями
///
class NotificationManager {
  /// Флаг инициализации
  bool _initialized = false;

  /// Менеджер по работе с токеном Firebase
  final _firebaseTokenManager = _FirebaseTokenManager();

  /// Менеджер по работе с пушами от Firebase
  final _firebaseNotificationManager = _FirebaseNotificationsManager();

  /// Мендежер по работе с локальными уведомлениями
  final _localNotificationsManager = _LocalNotificationsManager();

  /// Стрим контроллер для [PushData] полученных при нажатии на уведомления
  final _pushDataStreamController = BehaviorSubject<PushData>();

  /// Стрим для [PushData] полученных при нажатии на уведомления
  Stream<PushData> get pushDataStream => _pushDataStreamController.stream;

  /// Инициализация
  ///
  /// - Инициализирует [_firebaseTokenManager]
  /// - Инициализирует [_localNotificationsManager]
  /// - Инициализирует [_firebaseNotificationManager]
  ///
  Future<void> init() async {
    /// TODO: убрать Platform
    if (_initialized || Platform.isIOS) return;
    await _firebaseTokenManager.init();
    await _localNotificationsManager.init(
      _handleNotificationData,
    );
    await _firebaseNotificationManager.init(
      onNewMessageInForeground: _localNotificationsManager.showNotification,
      onNotificationTap: _handleNotificationData,
    );
    _initialized = true;
  }

  /// Метод для обработки данных полученных из уведомления
  ///
  /// - Парисит мапу [data] и добавляет в стрим [PushData] с информацией о
  /// странице, которую необходимо открыть при нажатии на пуш
  ///
  void _handleNotificationData(Map<String, dynamic> data) {
    final pushData = PushData.fromMap(data);
    _pushDataStreamController.add(pushData);
  }
}
