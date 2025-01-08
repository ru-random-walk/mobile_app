import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

class BaseDialog extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  const BaseDialog({
    super.key,
    required this.width,
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.base_0,
            borderRadius: BorderRadius.circular(16.toFigmaSize),
          ),
          child: child,
        ),
      ),
    );
  }
}
