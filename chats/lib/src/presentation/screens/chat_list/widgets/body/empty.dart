part of '../../page.dart';

class _ChatListBodyEmptyDataWidget extends StatelessWidget {
  const _ChatListBodyEmptyDataWidget();

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.toFigmaSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'packages/chats/assets/images/no_chats.png',
                height: 160.toFigmaSize,
                width: 200.toFigmaSize,
              ),
              SizedBox(
                height: 31.5.toFigmaSize,
              ),
              Text(
                'Чатов пока нет',
                style: context.textTheme.h5.copyWith(
                  color: context.colors.base_90,
                ),
              ),
              SizedBox(
                height: 8.toFigmaSize,
              ),
              Text(
                'Ваши чаты появятся здесь поле назначения прогулки',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMItalic.copyWith(
                  color: context.colors.base_50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
