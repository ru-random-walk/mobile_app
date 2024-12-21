part of '../../../../page.dart';

class _SpecficDatePickBaseButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  const _SpecficDatePickBaseButton({
    required this.title,
    this.onTap,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      type: ButtonType.secondary,
      size: ButtonSize.S,
      onPressed: onTap,
      text: title,
      color: ButtonColor.grey,
      isMaxWidth: false,
      padding: padding,
    );
  }
}
