part of '../../../screens.dart';

final _appBarHeight = 56.toFigmaSize;

class _GroupListAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20.toFigmaSize),
        Expanded(
          child: Text(
            'My Groups',
            style: context.textTheme.h4.copyWith(
              color: context.colors.base_90,
            ),
          ),
        ),
        SizedBox(width: 16.toFigmaSize),
        _SearchButton(),
        SizedBox(width: 20.toFigmaSize),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_appBarHeight);
}
