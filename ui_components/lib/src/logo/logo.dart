import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_utils/ui_utils.dart';

class AppLogo extends StatelessWidget {
  final double size;

  AppLogo({super.key, double? size}) : size = size ?? 120.toFigmaSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: SvgPicture.asset(
        'packages/ui_components/assets/logo/random_walk_logo.svg',
        fit: BoxFit.contain,
      ),
    );
  }
}
