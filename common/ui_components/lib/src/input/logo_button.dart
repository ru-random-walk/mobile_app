part of 'widget.dart';

class _LogoButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _LogoButton({
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AppLogo(
        size: 28.toFigmaSize,
      ),
    );
  }
}
