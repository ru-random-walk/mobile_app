part of '../page.dart';

final _appBarHeight = 56.toFigmaSize;

class _MeetingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _MeetingsAppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20.toFigmaSize),
        Expanded(
          child: Text(
            'Meetings',
            style: context.textTheme.h4.copyWith(
              color: context.colors.base_90,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_appBarHeight);
}
