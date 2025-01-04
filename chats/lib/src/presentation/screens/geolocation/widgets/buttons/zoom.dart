part of '../../page.dart';

class _ZoomMapButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _BaseMapInterfaceButton(
            child: getIcon(_PlusPaint()),
          ),
          SizedBox(
            height: 16.toFigmaSize,
          ),
          _BaseMapInterfaceButton(
            child: getIcon(_MinusPaint()),
          ),
        ],
      ),
    );
  }

  Widget getIcon(CustomPainter painter) => SizedBox.square(
        dimension: 16.toFigmaSize,
        child: CustomPaint(
          painter: painter,
        ),
      );
}

class _PlusPaint extends CustomPainter {
  final Color color;

  _PlusPaint({
    super.repaint,
    Color? color,
  }) : color = color ?? Colors.black;

  @override
  void paint(Canvas canvas, Size size) {
    final side = size.shortestSide;
    final cell = side / 16;

    final paint = Paint()
      ..color = color
      ..strokeWidth = cell * 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(side / 2, 0),
      Offset(side / 2, side),
      paint,
    );

    canvas.drawLine(
      Offset(0, side / 2),
      Offset(side, side / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MinusPaint extends CustomPainter {
  final Color color;

  _MinusPaint({
    super.repaint,
    Color? color,
  }) : color = color ?? Colors.black;

  @override
  void paint(Canvas canvas, Size size) {
    final side = size.shortestSide;
    final cell = side / 16;

    final paint = Paint()
      ..color = color
      ..strokeWidth = cell * 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(0, side / 2),
      Offset(side, side / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
