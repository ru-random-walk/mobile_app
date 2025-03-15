part of '../page.dart';

class _AvailableTimePageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _AvailableTimePageAppBar();

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
