import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

class PickerConfirmButton extends StatelessWidget {
  final VoidCallback? onTap;

  const PickerConfirmButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      type: ButtonType.primary,
      size: ButtonSize.S,
      onPressed: onTap,
      text: 'Готово',
      color: ButtonColor.green,
      padding: EdgeInsets.symmetric(
        vertical: 12.toFigmaSize,
      ),
    );
  }
}
