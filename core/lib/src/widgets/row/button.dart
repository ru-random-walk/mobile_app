part of 'widgets.dart';

class _MeetDataPickButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Widget? icon;
  final double? width;
  final ButtonSize size;

  const _MeetDataPickButton({
    super.key,
    required this.title,
    this.onTap,
    this.icon,
    this.width,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: CustomButton(
        padding: EdgeInsets.symmetric(
          vertical: 8.toFigmaSize,
          horizontal: 2.toFigmaSize,
        ),
        type: ButtonType.secondary,
        text: title,
        color: ButtonColor.grey,
        size: size,
        rightIcon: rightIcon,
        isMaxWidth: false,
        onPressed: onTap,
      ),
    );
  }

  Widget? get rightIcon {
    if (icon != null) {
      return Padding(
        padding: EdgeInsets.only(
          left: 8.toFigmaSize,
        ),
        child: SizedBox.square(
          dimension: _iconSide,
          child: icon,
        ),
      );
    }
    return null;
  }

  double get _iconSide => switch (size) {
        ButtonSize.S => 16.toFigmaSize,
        ButtonSize.M => 24.toFigmaSize,
      };
}
