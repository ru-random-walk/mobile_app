import 'package:chats/src/presentation/shared/cross_paint.dart';
import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

class DialogPickerHeaderCloseButton extends StatelessWidget {
  final double size;

  DialogPickerHeaderCloseButton({double? size})
      : size = size ?? 16.toFigmaSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: CustomPaint(
          painter: CrossPaint(
            color: context.colors.base_30,
          ),
        ),
      ),
    );
  }
}
