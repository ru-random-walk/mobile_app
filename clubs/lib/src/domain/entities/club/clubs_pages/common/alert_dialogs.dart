import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

class ConfirmActionDialog  extends StatelessWidget {
  final String message;
  final String? subMessage;
  final String confirmText;
  final VoidCallback onConfirm;
  final Color? customColor;

  const ConfirmActionDialog ({
    super.key,
    required this.message,
    this.subMessage,
    required this.confirmText,
    required this.onConfirm,
    this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.toFigmaSize),
      ),
      contentPadding: EdgeInsets.all(16.toFigmaSize),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20.toFigmaSize),
          Text(
            message,
            style: context.textTheme.bodyXLMedium.copyWith(color: context.colors.base_80),
            textAlign: TextAlign.center,
          ),
          if (subMessage != null) ...[
            SizedBox(height: 16.toFigmaSize),
            Text(
              subMessage!,
              style: context.textTheme.bodyLRegular.copyWith(color: context.colors.base_70),
              textAlign: TextAlign.center,
            ),
          ],
          SizedBox(height: 28.toFigmaSize),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  size: ButtonSize.M,
                  type: ButtonType.secondary,
                  color: ButtonColor.grey,
                  text: 'Отмена',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              SizedBox(width: 16.toFigmaSize),
              Expanded(
                child: CustomButton(
                    size: ButtonSize.M,
                    type: ButtonType.primary,
                    text: confirmText,
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm();
                    },
                    color: ButtonColor.grey,
                    customColor: customColor,
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
