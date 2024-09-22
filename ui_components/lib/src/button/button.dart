import 'package:flutter/material.dart';
import 'package:ui_theming/ui_theming.dart';
import 'package:ui_utils/ui_utils.dart';

import 'color.dart';
import 'size.dart';
import 'type.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final String text;
  final ButtonSize size;
  final ButtonColor color;
  final ButtonType type;

  const CustomButton({
    super.key,
    this.onPressed,
    this.leftIcon,
    this.rightIcon,
    required this.text,
    this.size = ButtonSize.M,
    this.color = ButtonColor.green,
    this.type = ButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final style = _getStyle(colors);
    return SizedBox(
      height: _height,
      width: double.infinity,
      child: OutlinedButton(
        style: style,
        onPressed: onPressed,
        child: child,
      ),
    );
  }

  double get _height => switch (size) {
        ButtonSize.S => 40.toFigmaSize,
        ButtonSize.M => 52.toFigmaSize,
      };

  Widget get child {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leftIcon != null) leftIcon!,
        Text(text),
        if (rightIcon != null) rightIcon!,
      ],
    );
  }

  ButtonStyle _getStyle(ExtendedTheme theme) => switch (type) {
        ButtonType.primary => _getPrimaryStyle(theme),
        ButtonType.secondary => _getSecondaryStyle(theme),
        ButtonType.tertiary => throw UnimplementedError(),
      };

  Color _getColor(ExtendedTheme theme) {
    switch (color) {
      case ButtonColor.green:
        return theme.main_50;
      case ButtonColor.grey:
        return theme.base_50;
    }
  }

  Color _getOnPressedColor(ExtendedTheme theme) {
    switch (color) {
      case ButtonColor.green:
        return theme.main_70;
      case ButtonColor.grey:
        return theme.base_90;
    }
  }

  ButtonStyle _getPrimaryStyle(ExtendedTheme theme) {
    return ButtonStyle(
      side: const WidgetStatePropertyAll(BorderSide.none),
      shape: WidgetStateProperty.all(_border),
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.pressed)) {
          return _getOnPressedColor(theme);
        }
        return _getColor(theme);
      }),
    );
  }

  OutlinedBorder get _border => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.toFigmaSize),
      );

  ButtonStyle _getSecondaryStyle(ExtendedTheme theme) {
    final side = BorderSide(
      color: _getColor(theme),
      width: 1.toFigmaSize,
    );
    return ButtonStyle(
      foregroundColor:  WidgetStateProperty.all<Color>(Colors.yellow),
      overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
      surfaceTintColor: WidgetStateProperty.all<Color>(Colors.transparent),
      backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
      shape: WidgetStateProperty.all(_border),
      side: WidgetStateProperty.resolveWith<BorderSide>(
        (states) {
          if (states.contains(WidgetState.pressed)) {
            return side.copyWith(color: _getOnPressedColor(theme));
          }
          return side;
        },
      ),
    );
  }
}
