part of '../../page.dart';

class _ChatTextMessageWidget extends StatelessWidget {
  final TextMessageEntity message;

  const _ChatTextMessageWidget({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseChatMessageWidget(
      maxWidth: 320.toFigmaSize,
      isMy: message.isMy,
      timestamp: message.timestamp,
      child: Text(
        message.text,
        style: context.textTheme.bodyMRegularBase90,
      ),
    );
  }
}
