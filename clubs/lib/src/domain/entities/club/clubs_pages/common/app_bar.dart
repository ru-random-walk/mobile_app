import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

class ClubPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showMenu;
  final void Function(double dY)? onMenuPressed;
  final VoidCallback? onBackPressed;

  const ClubPageAppBar({
    super.key,
    this.title,
    this.showMenu = false,
    this.onMenuPressed,
    this.onBackPressed,
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
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            if (title != null) ...[
              SizedBox(width: 16.toFigmaSize),
              Text(title!, 
                style: context.textTheme.h5.copyWith(color: context.colors.base_90),),
            ],
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
