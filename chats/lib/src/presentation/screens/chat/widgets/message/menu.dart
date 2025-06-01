part of '../../page.dart';

class _TextMessageMenuWidget extends StatelessWidget {
  final Offset anchorPoint;
  final TextMessageEntity message;

  const _TextMessageMenuWidget({
    required this.anchorPoint,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildLayout(
      delegate: _TextMessageMenuDelegate(anchorPoint),
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              leftIcon: Padding(
                padding: EdgeInsets.only(right: 8.toFigmaSize),
                child: Icon(
                  size: 16.toFigmaSize,
                  Icons.copy,
                ),
              ),
              text: 'Копировать',
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(
                    text: message.text,
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TextMessageMenuDelegate extends SingleChildLayoutDelegate {
  final Offset anchorPoint;

  _TextMessageMenuDelegate(this.anchorPoint);

  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) => false;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(
      Size(
        150.toFigmaSize,
        constraints.maxHeight,
      ),
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    var dx = anchorPoint.dx - childSize.width;
    if (dx < 0) {
      dx = 0;
    }
    var dy = anchorPoint.dy - childSize.height;
    if (dy < 0) {
      dy = 0;
    }
    return Offset(dx, dy);
  }
}
