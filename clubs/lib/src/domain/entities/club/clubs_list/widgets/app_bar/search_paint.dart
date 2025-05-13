part of '../../page.dart';

class _SearchPaint extends CustomPainter {
  final Color color;

  _SearchPaint({
    super.repaint,
    this.color = Colors.black,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final side = size.shortestSide;
    final cell = side / 24;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = cell * 2.5;
    final circleCenter = Offset(cell * 10, cell * 10);
    canvas.drawCircle(
      circleCenter,
      cell * 8.75,
      paint,
    );
    final startPoint = Offset(cell * 16, cell * 16);
    final finishPoint = Offset(cell * 22, cell * 22);
    canvas.drawLine(startPoint, finishPoint, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
