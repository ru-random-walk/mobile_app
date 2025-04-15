import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final void Function() onPressed;
  final double? width;
  final double height;

  const FilterButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
    this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final button = Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? context.colors.main_50 : context.colors.base_0,
        borderRadius: BorderRadius.circular(16.toFigmaSize),
        border: Border.all(
          color: isSelected ? context.colors.main_50 : context.colors.base_70,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.toFigmaSize),
      height: height,
      child: Text(
        label,
        style: context.textTheme.bodyMMedium.copyWith(
          color: isSelected ? context.colors.base_0 : context.colors.base_70,
        ),
      ),
    );

    return GestureDetector(
      onTap: onPressed,
      child: width != null
          ? SizedBox(width: width, height: height, child: button)
          : button,
    );
  }
}