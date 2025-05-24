import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

import 'dialog_text.dart';
import 'status.dart';
import 'type.dart';

class DialogWidget extends StatelessWidget {
  final UserEntity user;
  final bool isInvitation;
  final DialogType type;
  final String? text;
  final DateTime? date;

  const DialogWidget({
    super.key,
    required this.isInvitation,
    required this.type,
    this.text,
    Widget? avatar,
    this.date,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.toFigmaSize,
            color: context.colors.base_20,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.toFigmaSize),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 4.toFigmaSize),
            AvatarUserWidget(
              size: 60.toFigmaSize,
              user: user,
            ),
            SizedBox(width: 16.toFigmaSize),
            Expanded(
              child: DialogTextColumnWigdet(
                isInvitation: isInvitation,
                name: user.fullName,
                text: text ?? '',
              ),
            ),
            SizedBox(width: 16.toFigmaSize),
            DialogStatusWidget(
              type: type,
              date: date,
            ),
            SizedBox(width: 4.toFigmaSize),
          ],
        ),
      ),
    );
  }
}
