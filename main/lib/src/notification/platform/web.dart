import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:js_notifications/platform_interface/js_notifications_platform_interface.dart';
import 'package:logger/logger.dart';
import 'package:main/src/notification/manager.dart';
import 'package:web/web.dart';

void initListenToTapNotificationFromBackgrond(
  OnNotificationTap onNotificationTap,
) {
  window.onMessage.listen(
    (msg) {
      try {
        Logger().i('Window Message with type: ${msg.type}');
        final data = jsonDecode(msg.data.toString()) as Map<String, dynamic>;
        Logger().i('Window Message data: $data');
        onNotificationTap(data);
      } catch (e) {
        Logger().e(e.toString());
      }
    },
  );
}

void initListenToTapNotificationFromForeground(
  OnNotificationTap onNotificationTap,
) {
  JsNotificationsPlatform.instance.tapStream.listen(
    (data) => onNotificationTap(
      data.data ?? <String, dynamic>{},
    ),
  );
}

void showNotificationFromMessage(RemoteMessage message) {
  JsNotificationsPlatform.instance.showNotification(
    message.notification?.title ?? '',
    body: message.notification?.body,
    data: message.data,
  );
}
