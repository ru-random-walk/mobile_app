import 'package:core/src/widgets/shared/header/close_button.dart';
import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

class DialogPickerHeader extends StatelessWidget {
  const DialogPickerHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.toFigmaSize),
            child: Center(
              child: Text(
                title,
                style: context.textTheme.h5.copyWith(
                  color: context.colors.base_90,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 4.toFigmaSize,
        ),
        DialogPickerHeaderCloseButton(),
        SizedBox(
          width: 4.toFigmaSize,
        ),
      ],
    );
  }
}
