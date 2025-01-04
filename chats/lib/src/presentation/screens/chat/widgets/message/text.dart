part of '../../page.dart';

class _ChatTextMessageWidget extends StatelessWidget {
  final TextMessageEntity message;

  const _ChatTextMessageWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 320.toFigmaSize),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: getMessageBgColor(context),
            borderRadius: BorderRadius.circular(16.toFigmaSize),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.toFigmaSize,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 8.toFigmaSize,
                      bottom: 10.toFigmaSize,
                      right: 6.toFigmaSize,
                    ),
                    child: Text(
                      message.text,
                      style: context.textTheme.bodyMRegularBase90,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 4.toFigmaSize),
                  child: Text(
                    DateFormat.Hm().format(message.timestamp),
                    style: context.textTheme.captionRegular.copyWith(
                      color: context.colors.base_40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getMessageBgColor(BuildContext context) => switch (message) {
        MyMessageEntity _ => context.colors.main_10,
        FellowMessageEntity _ => context.colors.main_20,
      };

  Alignment get alignment => switch (message) {
        MyMessageEntity _ => Alignment.centerRight,
        FellowMessageEntity _ => Alignment.centerLeft,
      };
}
