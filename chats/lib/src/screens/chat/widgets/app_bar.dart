part of '../page.dart';

class _ChatAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88.toFigmaSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.base_0,
          border: Border(
            bottom: BorderSide(
              width: 1.toFigmaSize,
              color: context.colors.base_20,
            ),
          ),
        ),
        child: Row(
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
            UserAvatarWidget(
              avatar: Image.network(
                'https://i.pinimg.com/736x/5b/11/02/5b110284d575411305607bd16b615104.jpg',
                fit: BoxFit.cover,
              ),
              size: 52.toFigmaSize,
            ),
            SizedBox(
              width: 20.toFigmaSize,
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 4.toFigmaSize,
                  bottom: 7.toFigmaSize,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Maxim Selezsdfsdfsdfnevfsdfsdfdsf',
                      style: context.textTheme.h5.copyWith(
                        color: context.colors.base_90,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Online',
                      style: context.textTheme.bodyMRegularBase0.copyWith(
                        color: context.colors.base_40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(88.toFigmaSize);
}
