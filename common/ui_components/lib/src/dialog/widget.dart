import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

import 'dialog_text.dart';
import 'status.dart';
import 'type.dart';

class DialogWidget extends StatelessWidget {
  final String userId;
  final int photoVersion;
  final bool isInvitation;
  final DialogType type;
  final String? text;
  final DateTime? date;
  final String name;

  const DialogWidget({
    super.key,
    required this.isInvitation,
    required this.type,
    this.text,
    Widget? avatar,
    required this.name,
    this.date,
    required this.userId,
    required this.photoVersion,
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
              userId: userId,
              size: 60.toFigmaSize,
              photoVersion: photoVersion,
            ),
            SizedBox(width: 16.toFigmaSize),
            Expanded(
              child: DialogTextColumnWigdet(
                isInvitation: isInvitation,
                name: name,
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
