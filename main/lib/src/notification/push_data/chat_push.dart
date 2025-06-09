part of 'push_data.dart';

class ChatMessagePushData extends PushData {
  final String chatId;
  final String currentUserId;
  final String companionId;

  ChatMessagePushData._({
    required this.chatId,
    required this.currentUserId,
    required this.companionId,
  });

  /// Пример
  /// ```json
  /// {
  ///   "chat_members": [
  ///     "9690141c-2fb9-4a9d-bed4-46af329211ca",
  ///     "7ac6b37a-5e38-46d9-9c4d-7595be7c1cfa"
  ///   ],
  ///   "chatId": "782af25a-9202-4d6e-8dd6-db3a14227398",
  ///   "sender": "7ac6b37a-5e38-46d9-9c4d-7595be7c1cfa"
  /// }
  /// ```
  factory ChatMessagePushData.fromMap(
    Map<String, dynamic> data,
  ) {
    log('Data from push: $data');
    final chatId = data['chatId'] as String;
    final senderId = data['sender'] as String;
    final chatMemberIdsString = data['chat_members'] as String;
    final chatMemberIds =
        (chatMemberIdsString.substring(1, chatMemberIdsString.length - 1))
            .split(',');
    final currentUserId = chatMemberIds.firstWhere((id) => id != senderId);
    final companionId = chatMemberIds.firstWhere((id) => id != currentUserId);
    return ChatMessagePushData._(
      chatId: chatId,
      currentUserId: currentUserId.trim(),
      companionId: companionId.trim(),
    );
  }
}
