import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

class CreateGroupButton extends StatelessWidget {
  final VoidCallback onPressed; 

  const CreateGroupButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      size: ButtonSize.M,
      type: ButtonType.secondary,
      color: ButtonColor.green,
      leftIcon: _PlusIcon(),
      text: 'Добавить',
      customWidth: 154.toFigmaSize,
      onPressed: onPressed,
    );
  }
}

  class _PlusIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(24.toFigmaSize),
      painter: _PlusPainter(color: context.colors.main_50),
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