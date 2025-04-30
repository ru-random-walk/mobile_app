import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final double? size;
  final Color? activeColor;
  final Color? borderColor;
  final String? label; 
  final TextStyle? labelStyle; 

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size,
    this.activeColor,
    this.borderColor,
    this.label, 
    this.labelStyle, 
  });

  @override
  Widget build(BuildContext context) {
    final double resolvedSize = size ?? 24.toFigmaSize;
    final Color resolvedActiveColor = activeColor ?? context.colors.main_50;
    final Color resolvedBorderColor = borderColor ?? context.colors.base_50;

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: resolvedSize,
            height: resolvedSize,
            decoration: BoxDecoration(
              color: value ? resolvedActiveColor : Colors.transparent,
              borderRadius: BorderRadius.circular(4.toFigmaSize),
              border: Border.all(
                color: value ? resolvedActiveColor : resolvedBorderColor,
                width: 2,
              ),
            ),
            child: value
                ? Center(
                    child: Icon(
                      Icons.check,
                      size: resolvedSize * 0.8,
                      color: context.colors.base_0,
                    ),
                  )
                : null,
          ),
          if (label != null) ...[
            SizedBox(width: 8.toFigmaSize),
            Text(
              label!,
              style: labelStyle ?? context.textTheme.bodyMRegularBase90, 
            ),
          ],
        ],
      ),
    );
  }
}
