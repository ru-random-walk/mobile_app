import 'package:flutter/material.dart';

import 'package:ui_theming/src/constants/colors/colors.dart';

class ExtendedTheme extends ThemeExtension<ExtendedTheme> {
  /// Base colors
  ///
  final base_0 = BaseColors.base_0;
  final base_5 = BaseColors.base_5;
  final base_10 = BaseColors.base_10;
  final base_20 = BaseColors.base_20;
  final base_30 = BaseColors.base_30;
  final base_40 = BaseColors.base_40;
  final base_50 = BaseColors.base_50;
  final base_60 = BaseColors.base_60;
  final base_70 = BaseColors.base_70;
  final base_80 = BaseColors.base_80;
  final base_90 = BaseColors.base_90;

  /// Main colors
  ///
  final Color main_5;
  final Color main_7;
  final Color main_10;
  final Color main_15;
  final Color main_20;
  final Color main_30;
  final Color main_40;
  final Color main_50;
  final Color main_60;
  final Color main_70;
  final Color main_80;
  final Color main_90;
  final Color main_100;

  const ExtendedTheme({
    required this.main_5,
    required this.main_7,
    required this.main_10,
    required this.main_15,
    required this.main_20,
    required this.main_30,
    required this.main_40,
    required this.main_50,
    required this.main_60,
    required this.main_70,
    required this.main_80,
    required this.main_90,
    required this.main_100,
  });

  @override
  ExtendedTheme copyWith({
    Color? main_5,
    Color? main_7,
    Color? main_10,
    Color? main_15,
    Color? main_20,
    Color? main_30,
    Color? main_40,
    Color? main_50,
    Color? main_60,
    Color? main_70,
    Color? main_80,
    Color? main_90,
    Color? main_100,
  }) {
    return ExtendedTheme(      
      main_5: main_5 ?? this.main_5,
      main_7: main_7 ?? this.main_7,
      main_10: main_10 ?? this.main_10,
      main_15: main_15 ?? this.main_15,
      main_20: main_20 ?? this.main_20,
      main_30: main_30 ?? this.main_30,
      main_40: main_40 ?? this.main_40,
      main_50: main_50 ?? this.main_50,
      main_60: main_60 ?? this.main_60,
      main_70: main_70 ?? this.main_70,
      main_80: main_80 ?? this.main_80,
      main_90: main_90 ?? this.main_90,
      main_100: main_100 ?? this.main_100,
    );
  }

  @override
  ThemeExtension<ExtendedTheme> lerp(
      covariant ThemeExtension<ExtendedTheme>? other, double t) {
    if (other is! ExtendedTheme) {
      return this;
    }
    return ExtendedTheme(
      main_5: Color.lerp(main_5, other.main_5, t)!,
      main_7: Color.lerp(main_7, other.main_7, t)!,
      main_10: Color.lerp(main_10, other.main_10, t)!,
      main_15: Color.lerp(main_15, other.main_15, t)!,
      main_20: Color.lerp(main_20, other.main_20, t)!,
      main_30: Color.lerp(main_30, other.main_30, t)!,
      main_40: Color.lerp(main_40, other.main_40, t)!,
      main_50: Color.lerp(main_50, other.main_50, t)!,
      main_60: Color.lerp(main_60, other.main_60, t)!,
      main_70: Color.lerp(main_70, other.main_70, t)!,
      main_80: Color.lerp(main_80, other.main_80, t)!,
      main_90: Color.lerp(main_90, other.main_90, t)!,
      main_100: Color.lerp(main_100, other.main_100, t)!,
    );
  }
}
