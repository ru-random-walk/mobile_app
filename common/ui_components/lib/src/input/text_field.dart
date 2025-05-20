import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final Widget? suffix;
  final double height;
  final double radius;
  final bool showDifferentBorders;
  final int? maxLines;
  final TextStyle? textStyle;
  final void Function(String)? onSubmitted;

  CustomTextField({
    super.key,
    required this.controller,
    this.hint,
    this.suffix,
    required this.height,
    double? radius,
    this.showDifferentBorders = true,
    this.maxLines,
    this.textStyle,
    this.onSubmitted,
  }) : radius = radius ?? 16.toFigmaSize;

  @override
  Widget build(BuildContext context) {
    final focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: context.colors.main_80,
        width: 1.toFigmaSize,
      ),
      borderRadius: BorderRadius.circular(
        radius,
      ),
    );
    final usualBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: context.colors.base_20,
        width: 1.toFigmaSize,
      ),
      borderRadius: BorderRadius.circular(
        radius,
      ),
    );
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: height,
        maxHeight: height * 2,
      ),
      child: TextField(
        style: textStyle ?? context.textTheme.bodySRegular,
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        controller: controller,
        maxLines: maxLines,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 4.toFigmaSize),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          fillColor: context.colors.base_0,
          focusedBorder: focusedBorder,
          border: showDifferentBorders ? usualBorder : focusedBorder,
          hintText: hint,
          suffixIconConstraints: BoxConstraints.loose(
            Size(
              (28 + 12).toFigmaSize,
              28.toFigmaSize,
            ),
          ),
          suffixIcon: suffix,
        ),
      ),
    );
  }
}
