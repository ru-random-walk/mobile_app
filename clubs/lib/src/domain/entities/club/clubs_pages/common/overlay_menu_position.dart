import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

class MenuLayoutDelegate extends SingleChildLayoutDelegate {
  final double dY;

  const MenuLayoutDelegate(this.dY);

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(
        Size(constraints.maxWidth, constraints.maxHeight));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final dx = size.width - 10.toFigmaSize - childSize.width;
    return Offset(dx, dY);
  }

  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) => false;
}
