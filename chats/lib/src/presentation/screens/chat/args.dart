import 'package:auth/auth.dart';

sealed class ChatPageArgs {
  final String chatId;
  final String currentUserId;

  String get companionId;

  ChatPageArgs({
    required this.chatId,
    required this.currentUserId,
  });
}

class ChatPageArgsWithCompanion extends ChatPageArgs {
  final UserEntity companion;

  ChatPageArgsWithCompanion({
    required super.chatId,
    required super.currentUserId,
    required this.companion,
  });

  @override
  String get companionId => companion.id;
}

class ChatPageArgsWithOnlyCompanionId extends ChatPageArgs {
  @override
  final String companionId;

  ChatPageArgsWithOnlyCompanionId({
    required super.chatId,
    required super.currentUserId,
    required this.companionId,
  });
}
