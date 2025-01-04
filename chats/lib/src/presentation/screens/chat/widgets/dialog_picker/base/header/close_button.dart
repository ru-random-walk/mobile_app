part of '../../../../page.dart';

class _DialogPickerHeaderCloseButton extends StatelessWidget {
  final double size;

  _DialogPickerHeaderCloseButton({double? size})
      : size = size ?? 16.toFigmaSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: CustomPaint(
          painter: CrossPaint(
            color: context.colors.base_30,
          ),
        ),
      ),
    );
  }
}
