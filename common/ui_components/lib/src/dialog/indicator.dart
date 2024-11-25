import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_utils/ui_utils.dart';

import 'type.dart';

class DialogStatusIndicator extends StatelessWidget {
  final DialogType type;

  const DialogStatusIndicator({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) => switch (type) {
        Recieved e => _getRecivedWidget(e, context),
        Sended e => _getCheckWidget(e),
        Readed e => _getCheckWidget(e),
      };

  // TODO: рефакторинг
  Widget _getRecivedWidget(Recieved type, BuildContext context) {
    return SizedBox.square(
      dimension: 28.toFigmaSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.main_40,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            type.amount.toString(),
            style: context.textTheme.h5.copyWith(color: context.colors.base_0),
          ),
        ),
      ),
    );
  }

  // TODO: рефакторинг
  Widget _getCheckWidget(DialogType type) {
    final path = switch (type) {
      Sended _ => 'assets/icons/checked.svg',
      Readed _ => 'assets/icons/double_tick.svg',
      _ => '',
    };
    return Padding(
      padding: EdgeInsets.only(top: 4.toFigmaSize),
      child: SizedBox.square(
        dimension: 24.toFigmaSize,
        child: SvgPicture.asset(
          path,
          fit: BoxFit.contain,
          package: 'ui_components',
        ),
      ),
    );
  }
}
