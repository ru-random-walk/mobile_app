part of '../page.dart';

class _AddMeetingButton extends StatelessWidget {
  const _AddMeetingButton();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: context.colors.base_0,
              borderRadius: BorderRadius.circular(
                6.toFigmaSize,
              )),
        ),
      ),
      CustomButton(
        text: null,
        type: ButtonType.secondary,
        color: ButtonColor.grey,
        rightIcon: _PlusIcon(),
        isMaxWidth: false,
        padding: EdgeInsets.all(
          18.toFigmaSize,
        ),
        customHeight: 60.toFigmaSize,
        customWidth: 60.toFigmaSize,
        onPressed: () => context
            .findAncestorStateOfType<_MatcherPageState>()
            ?.addAvailableTime(context),
      ),
    ]);
  }
}

class _PlusIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(24.toFigmaSize),
      painter: _PlusPainter(color: context.colors.base_70),
    );
  }
}

class _PlusPainter extends CustomPainter {
  final Color color;

  _PlusPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final side = size.shortestSide;
    final cell = side / 24;
    final strokeWidth = cell * 2;
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color;
    canvas.drawLine(Offset(side / 2, 0), Offset(side / 2, side), paint);
    canvas.drawLine(Offset(0, side / 2), Offset(side, side / 2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
