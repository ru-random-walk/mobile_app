part of '../../../../page.dart';

class _MeetDataPickButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Widget? icon;

  const _MeetDataPickButton({
    super.key,
    required this.title,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210.toFigmaSize,
      child: CustomButton(
        padding: EdgeInsets.symmetric(
          vertical: 8.toFigmaSize,
        ),
        type: ButtonType.secondary,
        text: title,
        color: ButtonColor.grey,
        size: ButtonSize.S,
        rightIcon: rightIcon,
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
        child: icon,
      );
    }
    return null;
  }
}
