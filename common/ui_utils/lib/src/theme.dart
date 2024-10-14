import 'package:flutter/material.dart';
import 'package:ui_theming/ui_theming.dart';

extension ThemingExtension on BuildContext {
  ExtendedTheme get colors => Theme.of(this).extension<ExtendedTheme>()!;

  TextThemeExtension get textTheme => Theme.of(this).extension<TextThemeExtension>()!;
}