part of '../not_member_page.dart';

class ClubNotMemberAppBar extends StatelessWidget implements PreferredSizeWidget {

  const ClubNotMemberAppBar({super.key,});

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