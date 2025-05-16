import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

class ClubPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showMenu;
  final void Function(double dY)? onMenuPressed;

  const ClubPageAppBar({
    super.key,
    this.showMenu = false,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            IconButton(
              iconSize: 28.toFigmaSize,
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            const Spacer(),
            if (showMenu && onMenuPressed != null)
              Builder(builder: (context) {
                return IconButton(
                  iconSize: 28.toFigmaSize,
                  icon: const Icon(Icons.more_vert_outlined),
                  onPressed: () {
                    final renderBox = context.findRenderObject()! as RenderBox;
                    final dy = renderBox.localToGlobal(Offset.zero).dy + renderBox.size.height;
                    onMenuPressed!(dy);
                  },
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.toFigmaSize);
}
