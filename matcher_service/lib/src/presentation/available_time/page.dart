import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

part 'widgets/body/body.dart';
part 'widgets/body/date.dart';
part 'widgets/body/time.dart';
part 'widgets/body/geoolocation.dart';

class AvailableTimePage extends StatelessWidget {
  const AvailableTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 28.toFigmaSize,
          vertical: 12.toFigmaSize,
        ),
        child: _AvailableTimeBodyWidget(),
      ),
    );
  }
}
