import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

class CustomRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final double? size;
  final Color? activeColor;
  final Color? borderColor;
  final String? label; 
  final TextStyle? labelStyle; 

  const CustomRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.size,
    this.activeColor, 
    this.borderColor, 
    this.label, 
    this.labelStyle, 
  });

  bool get _isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    final double resolvedSize = size ?? 24.toFigmaSize;
    final Color resolvedActiveColor = activeColor ?? context.colors.main_50;
    final Color resolvedBorderColor = borderColor ?? context.colors.base_50;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: resolvedSize,
            height: resolvedSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _isSelected ? resolvedActiveColor : resolvedBorderColor,
                width: 2,
              ),
            ),
            child: _isSelected
                ? Center(
                    child: Container(
                      width: resolvedSize * 0.5,
                      height: resolvedSize * 0.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: resolvedActiveColor,
                      ),
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

