part of '../page.dart';

class _MeetingInfoAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _MeetingInfoAppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          iconSize: 24.toFigmaSize,
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        const Spacer(),
        IconButton(
          iconSize: 28.toFigmaSize,
          icon: const Icon(
            Icons.more_vert_outlined,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.toFigmaSize);
}
