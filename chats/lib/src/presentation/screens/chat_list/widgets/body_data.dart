part of '../page.dart';

class _ChatListBodyData extends StatelessWidget {
  final String currentUserId;
  final List<ChatEntity> chats;

  const _ChatListBodyData({
    super.key,
    required this.chats,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        vertical: 8.toFigmaSize,
        horizontal: 16.toFigmaSize,
      ),
      itemBuilder: (_, index) {
        final chat = chats[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatPage(
                chatId: chat.id,
                currentUserId: currentUserId,
              ),
            ),
          ),
          child: DialogWidget(
            isInvitation: true,
            type: Readed(),
            text:
                'Lorem Ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            name: 'Maxim Seleznev',
            avatar: Image.network(
              'https://static.wikia.nocookie.net/adventuretimewithfinnandjake/images/9/97/S1e25_Finn_with_five_fingers.png/revision/latest/scale-to-width-down/971?cb=20131128031157',
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => SizedBox(
        height: 16.toFigmaSize,
      ),
      itemCount: chats.length,
    );
  }
}
