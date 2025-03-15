import 'package:flutter/material.dart';
import 'package:ui_theming/src/constants/colors/colors.dart';
import 'package:ui_theming/src/text_styles/styles.dart';
import 'package:ui_theming/src/themes/extension.dart';
import 'package:ui_theming/src/themes/text_extension.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: BaseColors.base_0,
  extensions: [
    lightColorTheme,
    lightTextTheme,
  ],
);

const lightColorTheme = ExtendedTheme(
  main_5: GreenColors.green_5,
  main_7: GreenColors.green_7,
  main_10: GreenColors.green_10,
  main_15: GreenColors.green_15,
  main_20: GreenColors.green_20,
  main_30: GreenColors.green_30,
  main_40: GreenColors.green_40,
  main_50: GreenColors.green_50,
  main_60: GreenColors.green_60,
  main_70: GreenColors.green_70,
  main_80: GreenColors.green_80,
  main_90: GreenColors.green_90,
  main_100: GreenColors.green_100,
);

final lightTextTheme = TextThemeExtension(
  h3: TextStyles.h3(Colors.black),
  h4: TextStyles.h4(Colors.black),
  h5: TextStyles.h5(Colors.black),
  bodyMRegularBase0: TextStyles.bodyMRegular(BaseColors.base_0),
  bodyMRegularBase70: TextStyles.bodyMRegular(BaseColors.base_70),
  bodyMRegularBase90: TextStyles.bodyMRegular(BaseColors.base_90),
  bodyMRegularMain50: TextStyles.bodyMRegular(GreenColors.green_50),
  bodyMRegularMain70: TextStyles.bodyMRegular(GreenColors.green_70),
  bodyXLMedium: TextStyles.bodyXLMedium(BaseColors.base_90),
  bodyLRegular: TextStyles.bodyLRegular(Colors.black),
  bodyMMedium: TextStyles.bodyMMedium(Colors.black),
  bodyMItalic: TextStyles.bodyMItalic(Colors.black),
  bodySRegular: TextStyles.bodySRegular(Colors.black),
  bodySMediumBase0: TextStyles.bodySMedium(BaseColors.base_0),
  bodySMediumBase70: TextStyles.bodySMedium(BaseColors.base_70),
  bodySMediumBase90: TextStyles.bodySMedium(BaseColors.base_90),
  bodySMediumMain50: TextStyles.bodySMedium(GreenColors.green_50),
  bodySMediumMain70: TextStyles.bodySMedium(GreenColors.green_70),
  bodySItalic: TextStyles.bodySItalic(Colors.black),
  captionRegular: TextStyles.captionRegular(Colors.black),
  captionMedium: TextStyles.captionMedium(Colors.black),
  captionItalic: TextStyles.captionItalic(Colors.black),
);
