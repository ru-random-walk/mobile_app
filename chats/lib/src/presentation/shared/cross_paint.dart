import 'package:flutter/material.dart';

class CrossPaint extends CustomPainter {
  final Color color;

  CrossPaint({
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
      Offset(cell, cell),
      Offset(side - cell, side - cell),
      paint,
    );

    canvas.drawLine(
      Offset(cell, side - cell),
      Offset(side - cell, cell),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
