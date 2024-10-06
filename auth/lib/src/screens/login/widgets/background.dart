import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

class LoginScreenBackground extends StatelessWidget {
  final Widget child;

  const LoginScreenBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.base_0,
      child: Stack(
        children: [
          Positioned(
            right: -80.toFigmaSize,
            bottom: -60.toFigmaSize,
            width: 270.toFigmaSize,
            height: 270.toFigmaSize,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF05CC31),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 90.toFigmaSize,
            bottom: -150.toFigmaSize,
            width: 270.toFigmaSize,
            height: 270.toFigmaSize,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF08B42B),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: -50.toFigmaSize,
            bottom: -100.toFigmaSize,
            child: Container(
              width: 260.toFigmaSize,
              height: 260.toFigmaSize,
              decoration: const BoxDecoration(
                color: Color(0xFF32CE32),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned.fill(
            child: Center(child: child),
          ),
        ],
      ),
    );
  }
}
