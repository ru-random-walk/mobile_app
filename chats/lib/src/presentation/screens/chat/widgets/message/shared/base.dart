part of '../../../page.dart';

class _BaseChatMessageWidget extends StatelessWidget {
  final Widget child;
  final bool isMy;
  final DateTime timestamp;
  final double maxWidth;
  final bool isTimeUnder;

  const _BaseChatMessageWidget({
    super.key,
    required this.child,
    required this.isMy,
    required this.timestamp,
    required this.maxWidth,
    this.isTimeUnder = false,
  });

  @override
  Widget build(BuildContext context) {
    final time = Padding(
      padding: EdgeInsets.only(bottom: 4.toFigmaSize),
      child: Text(
        DateFormat.Hm().format(timestamp),
        style: context.textTheme.captionRegular.copyWith(
          color: context.colors.base_40,
        ),
      ),
    );
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: getMessageBgColor(context),
            borderRadius: BorderRadius.circular(16.toFigmaSize),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.toFigmaSize,
            ),
            child: _getMainBody(child, time),
          ),
        ),
      ),
    );
  }

  Widget _getMainBody(Widget child, Widget time) {
    if (isTimeUnder) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          Align(
            alignment: Alignment.bottomRight,
            child: time,
          ),
        ],
      );
    }
    return Row(
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
            child: child,
          ),
        ),
        time,
      ],
    );
  }

  Color getMessageBgColor(BuildContext context) => switch (isMy) {
        true => context.colors.main_10,
        false => context.colors.main_20,
      };

  Alignment get alignment => switch (isMy) {
        true => Alignment.centerRight,
        false => Alignment.centerLeft,
      };
}
