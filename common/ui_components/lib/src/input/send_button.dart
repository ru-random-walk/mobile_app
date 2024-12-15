part of 'widget.dart';

class _SendButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _SendButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox.square(
        dimension: 24.toFigmaSize,
        child: SvgPicture.asset(
          'packages/ui_components/assets/icons/send.svg',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
