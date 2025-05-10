import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';


class CreateAndEditPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CreateAndEditPageAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          iconSize: 28.toFigmaSize,
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.toFigmaSize);
}
