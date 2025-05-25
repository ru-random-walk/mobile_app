part of '../../page.dart';

class _ChatMessageWidget extends StatelessWidget {
  final MessageEntity message;

  const _ChatMessageWidget({
    required this.message,
  });

  @override
  Widget build(BuildContext context) => switch (message) {
        InvitationMessageEntity e =>
          _ChatInvitationMessageWidget(invitation: e),
        TextMessageEntity e => _ChatTextMessageWidget(message: e),
      };
}
