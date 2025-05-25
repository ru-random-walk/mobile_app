// ignore_for_file: unused_element, unused_element_parameter

part of '../../page.dart';

class _SearchButton extends StatelessWidget {
  final double dimension;
  final Color? color;
  final VoidCallback? onTap;

  _SearchButton({
    super.key,
    double? dimension,
    this.color,
    this.onTap,
  }) : dimension = dimension ?? 24.toFigmaSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox.square(
        dimension: dimension,
        child: CustomPaint(
          painter: _SearchPaint(color: color ?? context.colors.base_70),
        ),
      ),
    );
  }
}
