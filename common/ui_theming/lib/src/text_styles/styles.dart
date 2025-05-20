import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

abstract class TextStyles {
  static const _fontFamily = 'Roboto';

  static TextStyle h3(Color color) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 40.toFigmaSize,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle h4(Color color) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 26.toFigmaSize,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle h5(Color color) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 20.toFigmaSize,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle bodyMRegular(Color color) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16.toFigmaSize,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle bodyXLRegular(Color color) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 20.toFigmaSize,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle bodyXLMedium(Color color) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 20.toFigmaSize,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle bodyLRegular(Color color) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18.toFigmaSize,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle bodyMMedium(Color color) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16.toFigmaSize,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle bodyMItalic(Color color) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16.toFigmaSize,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: color,
      );

  static TextStyle bodySRegular(Color color) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14.toFigmaSize,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle bodySMedium(Color color) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14.toFigmaSize,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle bodySItalic(Color color) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14.toFigmaSize,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: color,
      );

  static TextStyle captionRegular(Color color) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12.toFigmaSize,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle captionMedium(Color color) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12.toFigmaSize,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle captionItalic(Color color) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12.toFigmaSize,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: color,
      );

  static bodyLItalic(Color color) => TextStyle(
    fontFamily: _fontFamily,
        fontSize: 18.toFigmaSize,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: color,
  );

  static TextStyle bodyLMedium(Color color) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18.toFigmaSize,
        fontWeight: FontWeight.w500,
        color: color,
      );
}