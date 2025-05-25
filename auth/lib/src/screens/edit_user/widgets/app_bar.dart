part of '../page.dart';

class _EditUserAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const _EditUserAppBarWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 20.toFigmaSize,
        ),
        IconButton(
          iconSize: 28.toFigmaSize,
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        SizedBox(
          width: 16.toFigmaSize,
        ),
        Flexible(
          child: Text(
            'Edit profile',
            style: context.textTheme.h4.copyWith(
              color: context.colors.base_90,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.toFigmaSize);
}
