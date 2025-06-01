part of '../../page.dart';

class _ChatTextMessageWidget extends StatelessWidget {
  final TextMessageEntity message;

  const _ChatTextMessageWidget({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        showDialog(
          context: context,
          builder: (_) {
            return _TextMessageMenuWidget(
              anchorPoint: details.globalPosition,
              message: message,
            );
          },
        );
      },
      child: _BaseChatMessageWidget(
        maxWidth: 320.toFigmaSize,
        isMy: message.isMy,
        timestamp: message.timestamp,
        child: LinkifyText(
          message.text,
          textStyle: context.textTheme.bodyMRegularBase90,
          linkStyle: context.textTheme.bodyMRegularBase90.copyWith(
            color: context.colors.main_70,
            decoration: TextDecoration.underline,
            decorationColor: context.colors.main_70,
          ),
          linkTypes: const [LinkType.url],
          onTap: (link) {
            final uri = Uri.tryParse(link.value ?? '');
            if (uri != null) {
              launchUrl(uri);
            }
          },
        ),
      ),
    );
  }
}
