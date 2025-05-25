import 'package:auth/auth.dart';
import 'package:chats/src/domain/entity/chat/chat.dart';
import 'package:chats/src/domain/entity/message/base.dart';

List<ChatEntity> generateChats(int count) {
  return List.generate(count, (i) => ChatEntity(
    id: 'chat_$i',
    companion: UserEntity(
      id: 'companion_$i',
      fullName: 'User $i',
      photoVersion: 1, 
      description: '',
    ),
    lastMessage: TextMessageEntity(
      id: 'message_$i',
      timestamp: DateTime.now().subtract(Duration(minutes: i * 3)),
      isMy: i.isEven,
      isChecked: i % 3 == 0,
      text: 'Test message $i',
    ),
  ),);
}

DetailedUserEntity detailedUser = DetailedUserEntity(
  id: 'user_test1',
  fullName: 'Test User',
  email: 'testuser@example.com',
  photoVersion: 1, 
  description: '',
);
