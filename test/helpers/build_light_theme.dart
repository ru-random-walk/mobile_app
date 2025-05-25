import 'package:flutter/material.dart';
import 'package:ui_theming/src/constants/colors/colors.dart';
import 'package:ui_theming/src/text_styles/styles.dart';
import 'package:ui_theming/ui_theming.dart';

ThemeData buildLightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: BaseColors.base_0,
    extensions: [
      lightColorTheme,
      _buildTextThemeExtension(),
    ],
  );
}

TextThemeExtension _buildTextThemeExtension(){
  return TextThemeExtension(
    h3: TextStyles.h3(Colors.black),
    h4: TextStyles.h4(Colors.black),
    h5: TextStyles.h5(Colors.black),
    bodyMRegularBase0: TextStyles.bodyMRegular(BaseColors.base_0),
    bodyMRegularBase70: TextStyles.bodyMRegular(BaseColors.base_70),
    bodyMRegularBase90: TextStyles.bodyMRegular(BaseColors.base_90),
    bodyMRegularMain50: TextStyles.bodyMRegular(GreenColors.green_50),
    bodyMRegularMain70: TextStyles.bodyMRegular(GreenColors.green_70),
    bodyXLRegular: TextStyles.bodyXLRegular(GreenColors.green_90),
    bodyXLMedium: TextStyles.bodyXLMedium(BaseColors.base_90),
    bodyLRegular: TextStyles.bodyLRegular(Colors.black),
    bodyLMedium: TextStyles.bodyLMedium(Colors.black),
    bodyLItalic: TextStyles.bodyLItalic(Colors.black),
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
}
