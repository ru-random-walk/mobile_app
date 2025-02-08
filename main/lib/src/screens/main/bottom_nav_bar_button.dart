part of 'main_screen.dart';

class _BottomNavBarButton extends StatelessWidget {
  final String pathForIncative;
  final String pathForActive;
  final bool isSelected;
  final VoidCallback onTap;

  const _BottomNavBarButton({
    required this.isSelected,
    required this.onTap,
    required this.pathForIncative,
    required this.pathForActive,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SvgPicture.asset(
        isSelected ? pathForActive : pathForIncative,
        width: 28.toFigmaSize,
        height: 28.toFigmaSize,
      ),
    );
  }
}
