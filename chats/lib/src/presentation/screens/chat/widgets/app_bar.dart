part of '../page.dart';

class _ChatAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const _ChatAppBarWidget();

  double get appBarHeight => 70.toFigmaSize;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChatBloc, ChatState, UserEntity?>(
      selector: (state) => state.companion,
      builder: (context, companion) {
        return SizedBox(
          height: appBarHeight,
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
                companion == null
                    ? SizedBox.square(
                        dimension: 52.toFigmaSize,
                        child: const CircularProgressIndicator.adaptive(),
                      )
                    : AvatarUserWidget(
                        user: companion,
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
                          companion?.fullName ?? 'Загрузка...',
                          style: context.textTheme.h5.copyWith(
                            color: context.colors.base_90,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
