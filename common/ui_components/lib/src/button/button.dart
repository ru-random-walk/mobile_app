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
  final String? text;
  final TextStyle? textStyle;
  final ButtonSize size;
  final ButtonColor color;
  final ButtonType type;
  final bool isMaxWidth;
  final EdgeInsets? padding;
  final double? customHeight;
  final double? customWidth;
  final Color? secondaryStyleFillColor;
  final Color? customColor;
  final double? customCornerRadius;
  final bool disabled;

  const CustomButton({
    super.key,
    this.textStyle,
    this.onPressed,
    this.leftIcon,
    this.rightIcon,
    required this.text,
    this.isMaxWidth = true,
    this.padding,
    this.size = ButtonSize.M,
    this.color = ButtonColor.green,
    this.type = ButtonType.primary,
    this.customHeight,
    this.customWidth,
    this.secondaryStyleFillColor,
    this.customColor,
    this.customCornerRadius,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = _getStyle(context);
    return IgnorePointer(
      ignoring: disabled,
      child: SizedBox(
        height: _height,
        width: _width,
        child: OutlinedButton(
          style: style,
          onPressed: onPressed,
          child: child(context.textTheme),
        ),
      ),
    );
  }

  double? get _width {
    if (customWidth != null) return customWidth;
    return isMaxWidth ? double.infinity : null;
  }

  double get _height =>
      customHeight ??
      switch (size) {
        ButtonSize.S => 40.toFigmaSize,
        ButtonSize.M => 52.toFigmaSize,
      };

  Widget child(TextThemeExtension textStyles) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leftIcon != null) leftIcon!,
        if (text != null)
          Flexible(
            child: Text(
              text ?? '',
              style: textStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        if (rightIcon != null) SizedBox.square(child: rightIcon!),
      ],
    );
  }

  ButtonStyle _getStyle(BuildContext context) => switch (type) {
        ButtonType.primary => _getPrimaryStyle(context),
        ButtonType.secondary => _getSecondaryStyle(context),
        ButtonType.tertiary => _getTeritaryStyle(context),
      };

  Color _getColor(ExtendedTheme theme) {
    if (disabled) return theme.base_20;
    if (customColor != null) return customColor!;
    switch (color) {
      case ButtonColor.green:
        return theme.main_50;
      case ButtonColor.grey:
        return theme.base_50;
      case ButtonColor.black:
        return theme.base_90;
    }
  }

  Color _getOnPressedColor(ExtendedTheme theme) {
    switch (color) {
      case ButtonColor.green:
        return theme.main_70;
      case ButtonColor.grey:
        return theme.base_90;
      case ButtonColor.black:
        return Colors.black;
    }
  }

  ButtonStyle _getPrimaryStyle(BuildContext context) {
    final theme = context.colors;
    final textStyles = context.textTheme;
    return ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: WidgetStateProperty.resolveWith<EdgeInsets>(
        (_) =>
            padding ??
            EdgeInsets.symmetric(
              horizontal: 12.toFigmaSize,
              vertical: 16.toFigmaSize,
            ),
      ),
      textStyle: WidgetStatePropertyAll(_getTextStyleForPrimary(textStyles)),
      side: const WidgetStatePropertyAll(BorderSide.none),
      shape: WidgetStateProperty.all(_border),
      foregroundColor:
          WidgetStateProperty.resolveWith<Color>((_) => context.colors.base_0),
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.pressed)) {
          return _getOnPressedColor(theme);
        }
        return _getColor(theme);
      }),
    );
  }

  ButtonStyle _getTeritaryStyle(BuildContext context) {
    final theme = context.colors;
    final textStyles = context.textTheme;
    return ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size.zero),
      padding: WidgetStateProperty.resolveWith<EdgeInsets>(
        (_) =>
            padding ??
            EdgeInsets.symmetric(
              horizontal: 12.toFigmaSize,
              vertical: 16.toFigmaSize,
            ),
      ),
      textStyle: WidgetStatePropertyAll(_getTextStyleForTeritary(textStyles)),
      side: const WidgetStatePropertyAll(BorderSide.none),
      shape: WidgetStateProperty.all(_border),
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (_) => context.colors.base_60,
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.pressed)) {
          return theme.base_5;
        }
        return null;
      }),
    );
  }

  TextStyle _getTextStyleForTeritary(TextThemeExtension textTheme) =>
      switch (size) {
        ButtonSize.S => textTheme.bodySMediumBase0,
        ButtonSize.M => textTheme.bodyMMedium,
      };

  TextStyle _getTextStyleForPrimary(TextThemeExtension textTheme) =>
      switch (size) {
        ButtonSize.S => textTheme.bodySMediumBase0,
        ButtonSize.M => textTheme.bodyMRegularBase0,
      };

  TextStyle _getTextStyleForSecondary(
    TextThemeExtension textTheme,
    bool isPressed,
  ) =>
      switch (size) {
        ButtonSize.S when !isPressed => textTheme.bodySMediumBase90,
        ButtonSize.S when isPressed => textTheme.bodySMediumBase90,
        ButtonSize.M when !isPressed => textTheme.bodyMRegularMain50,
        ButtonSize.M when isPressed => textTheme.bodyMRegularMain70,
        _ => throw UnimplementedError(),
      };

  OutlinedBorder get _border => RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(customCornerRadius ?? 6.toFigmaSize),
      );

  ButtonStyle _getSecondaryStyle(BuildContext context) {
    final theme = context.colors;
    final textStyles = context.textTheme;
    final side = BorderSide(
      color: _getColor(theme),
      width: 1.toFigmaSize,
    );
    return ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: WidgetStateProperty.resolveWith<EdgeInsets>(
        (_) =>
            padding ??
            EdgeInsets.symmetric(
              horizontal: 12.toFigmaSize,
              vertical: 16.toFigmaSize,
            ),
      ),
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
          return _getTextStyleForSecondary(textStyles, false);
        },
      ),
      overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
      surfaceTintColor: WidgetStateProperty.all<Color>(Colors.transparent),
      backgroundColor: WidgetStateProperty.all<Color>(
        secondaryStyleFillColor ?? Colors.transparent,
      ),
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
