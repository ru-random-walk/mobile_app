import 'package:flutter/material.dart';

class TextThemeExtension extends ThemeExtension<TextThemeExtension> {
  final TextStyle h3;
  final TextStyle h4;
  final TextStyle h5;
  final TextStyle bodyMRegularBase0;
  final TextStyle bodyMRegularBase70;
  final TextStyle bodyMRegularBase90;
  final TextStyle bodyMRegularMain50;
  final TextStyle bodyMRegularMain70;
  final TextStyle bodyXLRegular;
  final TextStyle bodyXLMedium;
  final TextStyle bodyLRegular;
  final TextStyle bodyLMedium;
  final TextStyle bodyLItalic;
  final TextStyle bodyMMedium;
  final TextStyle bodyMItalic;
  final TextStyle bodySRegular;
  final TextStyle bodySMediumBase0;
  final TextStyle bodySMediumBase70;
  final TextStyle bodySMediumBase90;
  final TextStyle bodySMediumMain50;
  final TextStyle bodySMediumMain70;
  final TextStyle bodySItalic;
  final TextStyle captionRegular;
  final TextStyle captionMedium;
  final TextStyle captionItalic;

  const TextThemeExtension({
    required this.h3,
    required this.h4,
    required this.h5,
    required this.bodyMRegularBase0,
    required this.bodyMRegularBase70,
    required this.bodyMRegularBase90,
    required this.bodyMRegularMain50,
    required this.bodyMRegularMain70,
    required this.bodyXLRegular,
    required this.bodyXLMedium,
    required this.bodyLRegular,
    required this.bodyLMedium,
    required this.bodyLItalic,
    required this.bodyMMedium,
    required this.bodyMItalic,
    required this.bodySRegular,
    required this.bodySMediumBase0,
    required this.bodySMediumBase70,
    required this.bodySMediumBase90,
    required this.bodySMediumMain50,
    required this.bodySMediumMain70,
    required this.bodySItalic,
    required this.captionRegular,
    required this.captionMedium,
    required this.captionItalic,
  });

  @override
  TextThemeExtension copyWith({
    TextStyle? h3,
    TextStyle? h4,
    TextStyle? h5,
    TextStyle? bodyMRegularBase0,
    TextStyle? bodyMRegularBase70,
    TextStyle? bodyMRegularBase90,
    TextStyle? bodyMRegularMain50,
    TextStyle? bodyMRegularMain70,
    TextStyle? bodyXLRegular,
    TextStyle? bodyXLMedium,
    TextStyle? bodyLRegular,
    TextStyle? bodyLMedium,
    TextStyle? bodyLItalic,
    TextStyle? bodyMMedium,
    TextStyle? bodyMItalic,
    TextStyle? bodySRegular,
    TextStyle? bodySMediumBase0,
    TextStyle? bodySMediumBase70,
    TextStyle? bodySMediumBase90,
    TextStyle? bodySMediumMain50,
    TextStyle? bodySMediumMain70,
    TextStyle? bodySItalic,
    TextStyle? captionRegular,
    TextStyle? captionMedium,
    TextStyle? captionItalic,
  }) {
    return TextThemeExtension(
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      h5: h5 ?? this.h5,
      bodyMRegularBase0: bodyMRegularBase0 ?? this.bodyMRegularBase0,
      bodyMRegularBase70: bodyMRegularBase70 ?? this.bodyMRegularBase70,
      bodyMRegularBase90: bodyMRegularBase90 ?? this.bodyMRegularBase90,
      bodyMRegularMain50: bodyMRegularMain50 ?? this.bodyMRegularMain50,
      bodyMRegularMain70: bodyMRegularMain70 ?? this.bodyMRegularMain70,
      bodyXLRegular: bodyXLRegular ?? this.bodyXLRegular,
      bodyXLMedium: bodyXLMedium ?? this.bodyXLMedium,
      bodyLRegular: bodyLRegular ?? this.bodyLRegular,
      bodyLMedium: bodyLMedium ?? this.bodyLMedium,
      bodyLItalic: bodyLItalic ?? this.bodyLItalic,
      bodyMMedium: bodyMMedium ?? this.bodyMMedium,
      bodyMItalic: bodyMItalic ?? this.bodyMItalic,
      bodySRegular: bodySRegular ?? this.bodySRegular,
      bodySMediumBase0: bodySMediumBase0 ?? this.bodySMediumBase0,
      bodySMediumBase70: bodySMediumBase70 ?? this.bodySMediumBase70,
      bodySMediumBase90: bodySMediumBase90 ?? this.bodySMediumBase90,
      bodySMediumMain50: bodySMediumMain50 ?? this.bodySMediumMain50,
      bodySMediumMain70: bodySMediumMain70 ?? this.bodySMediumMain70,
      bodySItalic: bodySItalic ?? this.bodySItalic,
      captionRegular: captionRegular ?? this.captionRegular,
      captionMedium: captionMedium ?? this.captionMedium,
      captionItalic: captionItalic ?? this.captionItalic,
    );
  }

  @override
  ThemeExtension<TextThemeExtension> lerp(
      covariant ThemeExtension<TextThemeExtension>? other, double t) {
    if (other is! TextThemeExtension) {
      return this;
    }

    return TextThemeExtension(
      h3: TextStyle.lerp(h3, other.h3, t)!,
      h4: TextStyle.lerp(h4, other.h4, t)!,
      h5: TextStyle.lerp(h5, other.h5, t)!,
      bodyMRegularBase0:
          TextStyle.lerp(bodyMRegularBase0, other.bodyMRegularBase0, t)!,
      bodyMRegularBase70:
          TextStyle.lerp(bodyMRegularBase70, other.bodyMRegularBase70, t)!,
      bodyMRegularBase90:
          TextStyle.lerp(bodyMRegularBase90, other.bodyMRegularBase90, t)!,
      bodyMRegularMain50:
          TextStyle.lerp(bodyMRegularMain50, other.bodyMRegularMain50, t)!,
      bodyMRegularMain70:
          TextStyle.lerp(bodyMRegularMain70, other.bodyMRegularMain70, t)!,
      bodyLRegular: TextStyle.lerp(bodyLRegular, other.bodyLRegular, t)!,
      bodyLMedium: TextStyle.lerp(bodyLMedium, other.bodyLMedium, t)!,
      bodyLItalic: TextStyle.lerp(bodyLItalic, other.bodyLItalic, t)!,
      bodyXLRegular: TextStyle.lerp(bodyXLRegular, other.bodyXLRegular, t)!,
      bodyXLMedium: TextStyle.lerp(bodyXLMedium, other.bodyXLMedium, t)!,
      bodyMMedium: TextStyle.lerp(bodyMMedium, other.bodyMMedium, t)!,
      bodyMItalic: TextStyle.lerp(bodyMItalic, other.bodyMItalic, t)!,
      bodySRegular: TextStyle.lerp(bodySRegular, other.bodySRegular, t)!,
      bodySMediumBase0:
          TextStyle.lerp(bodySMediumBase0, other.bodySMediumBase0, t)!,
      bodySMediumBase70:
          TextStyle.lerp(bodySMediumBase70, other.bodySMediumBase70, t)!,
      bodySMediumBase90:
          TextStyle.lerp(bodySMediumBase90, other.bodySMediumBase90, t)!,
      bodySMediumMain50:
          TextStyle.lerp(bodySMediumMain50, other.bodySMediumMain50, t)!,
      bodySMediumMain70:
          TextStyle.lerp(bodySMediumMain70, other.bodySMediumMain70, t)!,
      bodySItalic: TextStyle.lerp(bodySItalic, other.bodySItalic, t)!,
      captionRegular: TextStyle.lerp(captionRegular, other.captionRegular, t)!,
      captionMedium: TextStyle.lerp(captionMedium, other.captionMedium, t)!,
      captionItalic: TextStyle.lerp(captionItalic, other.captionItalic, t)!,
    );
  }
}
