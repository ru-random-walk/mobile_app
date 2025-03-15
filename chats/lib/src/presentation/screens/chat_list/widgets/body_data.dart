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
                args: ChatPageArgs(
                  chatId: chat.id,
                  companion: chat.companion,
                  currentUserId: currentUserId,
                ),
              ),
            ),
          ),
          child: DialogWidget(
            isInvitation: true,
            type: Readed(),
            text:
                'Lorem Ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            name: chat.companion.fullName,
            avatar: Image.network(
              chat.companion.avatar,
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
