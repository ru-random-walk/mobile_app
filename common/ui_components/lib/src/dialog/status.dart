import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

import 'indicator.dart';
import 'type.dart';

class DialogStatusWidget extends StatelessWidget {
  final DialogType type;
  final DateTime date;

  const DialogStatusWidget({
    super.key,
    required this.type,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DialogStatusIndicator(type: type),
        SizedBox(height: 4.toFigmaSize),
        Text(
          '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}',
          style: context.textTheme.bodySRegular.copyWith(
            color: context.colors.base_50,
          ),
        ),
      ],
    );
  }
}
