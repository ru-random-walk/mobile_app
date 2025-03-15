import 'package:auth/auth.dart';

class ChatEntity {
  final String id;
  final UserEntity companion;

  ChatEntity({
    required this.id,
    required this.companion,
  });
}
