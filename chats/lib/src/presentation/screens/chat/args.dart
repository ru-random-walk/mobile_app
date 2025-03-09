import 'package:auth/auth.dart';

class ChatPageArgs {
  final String chatId;
  final UserEntity companion;
  final String currentUserId;

  ChatPageArgs({
    required this.chatId,
    required this.companion,
    required this.currentUserId,
  });
}
