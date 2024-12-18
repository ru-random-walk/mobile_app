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
  final TextStyle? textStyle;
  final ButtonSize size;
  final ButtonColor color;
  final ButtonType type;

  const CustomButton({
    super.key,
    this.textStyle,
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
    final style = _getStyle(context);
    return SizedBox(
      height: _height,
      width: double.infinity,
      child: OutlinedButton(
        style: style,
        onPressed: onPressed,
        child: child(context.textTheme),
      ),
    );
  }

  double get _height => switch (size) {
        ButtonSize.S => 40.toFigmaSize,
        ButtonSize.M => 52.toFigmaSize,
      };

  Widget child(TextThemeExtension textStyles) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leftIcon != null) leftIcon!,
        Text(text, style: textStyle),
        if (rightIcon != null) rightIcon!,
      ],
    );
  }

  ButtonStyle _getStyle(BuildContext context) => switch (type) {
        ButtonType.primary => _getPrimaryStyle(context),
        ButtonType.secondary => _getSecondaryStyle(context),
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

  ButtonStyle _getPrimaryStyle(BuildContext context) {
    final theme = context.colors;
    final textStyles = context.textTheme;
    return ButtonStyle(
      textStyle: WidgetStatePropertyAll(_getTextStyleForPrimary(textStyles)),
      side: const WidgetStatePropertyAll(BorderSide.none),
      shape: WidgetStateProperty.all(_border),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.pressed)) {
          return _getOnPressedColor(theme);
        }
        return _getColor(theme);
      }),
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.pressed)) {
          return _getOnPressedColor(theme);
        }
        return _getColor(theme);
      }),
    );
  }

  TextStyle _getTextStyleForPrimary(TextThemeExtension textTheme) =>
      switch (size) {
        ButtonSize.S => textTheme.bodySMediumBase0,
        ButtonSize.M => textTheme.bodyMRegularBase0,
      };

  TextStyle _getTextStyleForSecondary(
          TextThemeExtension textTheme, bool isPressed) =>
      switch (size) {
        ButtonSize.S when !isPressed => textTheme.bodySMediumMain50,
        ButtonSize.S when isPressed => textTheme.bodySMediumMain70,
        ButtonSize.M when !isPressed => textTheme.bodyMRegularMain50,
        ButtonSize.M when isPressed => textTheme.bodyMRegularMain70,
        _ => throw UnimplementedError(),
      };

  OutlinedBorder get _border => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.toFigmaSize),
      );

  ButtonStyle _getSecondaryStyle(BuildContext context) {
    final theme = context.colors;
    final textStyles = context.textTheme;
    final side = BorderSide(
      color: _getColor(theme),
      width: 1.toFigmaSize,
    );
    return ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(WidgetState.pressed)) {
            return _getOnPressedColor(theme);
          }
          return _getColor(theme);
        },
      ),
      textStyle: WidgetStateProperty.resolveWith<TextStyle>(
        (states) {
          if (states.contains(WidgetState.pressed)) {
            return _getTextStyleForSecondary(textStyles, true);
          }
          return _getTextStyleForSecondary(textStyles, true);
        },
      ),
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
