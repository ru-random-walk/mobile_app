part of 'main_screen.dart';

class _MainScreenBottomNavigationBar extends StatelessWidget {
  final void Function(int index) onTap;
  final int currentIndex;

  const _MainScreenBottomNavigationBar({
    required this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.toFigmaSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: context.colors.base_40,
              width: 1.toFigmaSize,
            ),
          ),
        ),
        child: Row(
          children: [
            for (var i = 0; i < 4; i++)
              Expanded(
                child: _BottomNavBarButton(
                  isSelected: currentIndex == i,
                  onTap: () => onTap(i),
                  pathForIncative: _pathsByIndex[i]!.$1,
                  pathForActive: _pathsByIndex[i]!.$2,
                ),
              )
          ],
        ),
      ),
    );
  }
}

const _pathsByIndex = {
  0: (ButtonsSVGPath.logo, ButtonsSVGPath.logoFilled),
  1: (ButtonsSVGPath.group, ButtonsSVGPath.groupFilled),
  2: (ButtonsSVGPath.chat, ButtonsSVGPath.chatFilled),
  3: (ButtonsSVGPath.settings, ButtonsSVGPath.settingsFilled),
};
