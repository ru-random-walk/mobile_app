part of 'widget.dart';

class _LogoButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _LogoButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AppLogo(
        size: 28.toFigmaSize,
      ),
    );
  }
}
