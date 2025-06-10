part of '../../page.dart';

class _ChatListBodyData extends StatelessWidget {
  final String currentUserId;
  final List<ChatEntity> chats;

  const _ChatListBodyData({
    required this.chats,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 8.toFigmaSize,
        horizontal: 16.toFigmaSize,
      ),
      sliver: SliverList.separated(
        itemBuilder: (_, index) {
          final chat = chats[index];
          final lastMessage = chat.lastMessage;
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatPage(
                  args: ChatPageArgsWithCompanion(
                    chatId: chat.id,
                    companion: chat.companion,
                    currentUserId: currentUserId,
                  ),
                  onLastMessageChanged: (message) {
                    context.read<ChatsListBloc>().add(
                          LastMessageChatUpdated(
                            chatId: chat.id,
                            message: message,
                          ),
                        );
                  },
                ),
              ),
            ),
            child: DialogWidget(
              isInvitation: lastMessage is InvitationMessageEntity,
              type: Readed(),
              text: lastMessage is TextMessageEntity ? lastMessage.text : null,
              user: chat.companion,
              date: lastMessage?.timestamp,
            ),
          );
        },
        separatorBuilder: (_, __) => SizedBox(
          height: 16.toFigmaSize,
        ),
        itemCount: chats.length,
      ),
    );
  }
}
