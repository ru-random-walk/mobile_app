import 'package:auth/auth.dart';
import 'package:chats/src/domain/entity/chat/chat.dart';
import 'package:chats/src/domain/entity/message/base.dart';

List<ChatEntity> generateMatcher(int count) {
  return List.generate(count, (i) => ChatEntity(
    id: 'chat_$i',
    companion: UserEntity(
      id: 'companion_$i',
      fullName: 'User $i',
      photoVersion: 1, 
      description: '', 
      avatar: 'test/fake_avatar.png',
    ),
    lastMessage: TextMessageEntity(
      id: 'message_$i',
      timestamp: DateTime(2024, 1, 1, 17, i * 3),
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
  avatar: 'test/fake_avatar.png',
);
