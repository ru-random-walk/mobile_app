import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:ui_components/ui_components.dart';

class AddGroupButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddGroupButton({
    super.key, 
    required this.onPressed,
    });

  @override
Widget build(BuildContext context) {
  return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.base_0,
        borderRadius: BorderRadius.circular(16.toFigmaSize),
      ),
        child: CustomButton(
          text: null,
          type: ButtonType.secondary,
          color: ButtonColor.grey,
          rightIcon: _PlusIcon(),
          isMaxWidth: false,
          padding: EdgeInsets.all(18.toFigmaSize),
          customHeight: 60.toFigmaSize,
          customWidth: 60.toFigmaSize,
          onPressed: onPressed,
          customCornerRadius: 16.toFigmaSize,
        ),
   );
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
