import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

import 'logo.dart';

class AppLogoWithTitle extends StatelessWidget {
  const AppLogoWithTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppLogo(),
        SizedBox(
          height: 4.toFigmaSize,
        ),
        Text(
          'Random Walk',
          style: context.textTheme.h3.copyWith(
            color: const Color(0xFF05CC31),
          ),
        ),
      ],
    );
  }
}
