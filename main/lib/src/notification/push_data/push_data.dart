import 'dart:developer';

part 'chat_push.dart';
part 'unknown.dart';

/// Модель данных приходящих в уведомлении от сервера
///
sealed class PushData {
  const PushData();

  factory PushData.fromMap(Map<String, dynamic> data) {
    if (data.containsKey('chatId')) {
      return ChatMessagePushData.fromMap(data);
    } else {
      return UnknownPushData();
    }
  }
}
