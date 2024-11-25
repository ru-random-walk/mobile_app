import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

class DialogTextColumnWigdet extends StatelessWidget {
  final bool isInvitation;
  final String name;
  final String text;

  const DialogTextColumnWigdet({
    super.key,
    required this.isInvitation,
    required this.name,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(name, style: context.textTheme.h5),
        SizedBox(height: 8.toFigmaSize),
        _getText(context)
      ],
    );
  }

  Widget _getText(BuildContext context) {
    if (isInvitation) {
      return Text(
        'Приглашение на встречу',
        style: context.textTheme.bodyMMedium.copyWith(
          color: context.colors.main_80,
        ),
      );
    }
    return Text(text, style: context.textTheme.bodyMRegularBase90);
  }
}
