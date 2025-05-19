part of '../../../page.dart';

class _ClubsListBodyEmpty extends StatelessWidget {
  final VoidCallback onFindGroup;

  const _ClubsListBodyEmpty({
    required this.onFindGroup,
  });

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
                'packages/clubs/assets/images/no_groups.png',
                height: 120.toFigmaSize,
                width: 200.toFigmaSize,
              ),
              SizedBox(
                height: 32.toFigmaSize,
              ),
              Text(
                'Здесь пока нет групп',
                style: context.textTheme.h5.copyWith(
                  color: context.colors.base_90,
                ),
              ),
              SizedBox(
                height: 8.toFigmaSize,
              ),
              Text(
                'Присоединяйтесь к интересным группам или создайте свою',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMItalic.copyWith(
                  color: context.colors.base_50,
                ),
              ),
              SizedBox(
                height: 32.toFigmaSize,
              ),
              CustomButton(
                text: 'Найти группу',
                leftIcon: SvgPicture.asset(
                  'packages/clubs/assets/icons/search.svg',
                  colorFilter: ColorFilter.mode(context.colors.base_0,
                    BlendMode.srcIn,),
                ),
                customWidth: 200.toFigmaSize,
                onPressed: onFindGroup,
              ),
              SizedBox(
                height: 16.toFigmaSize,
              ),
              CustomButton(
                text: 'Создать группу',
                leftIcon: SvgPicture.asset(
                  'packages/clubs/assets/icons/plus.svg',
                  colorFilter: ColorFilter.mode(context.colors.main_50,
                    BlendMode.srcIn,),
                ),
                type: ButtonType.secondary,
                customWidth: 200.toFigmaSize,
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ClubFormScreen()),
                  );
                  if (result == true) {
                    context.read<ClubsListBloc>().add(LoadClubsEvent());
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
