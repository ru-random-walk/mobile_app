import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final Widget? suffix;
  final double height;
  final double radius;
  final bool showDifferentBorders;

  CustomTextField({
    super.key,
    required this.controller,
    this.hint,
    this.suffix,
    required this.height,
    double? radius,
    this.showDifferentBorders = true,
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
    return SizedBox(
      height: height,
      child: TextField(
        style: context.textTheme.bodySRegular,
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        controller: controller,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          isDense: true,
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
