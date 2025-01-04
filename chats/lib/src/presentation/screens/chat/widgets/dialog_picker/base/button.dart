part of '../../../page.dart';

class _SpecficValuePickBaseButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  _SpecficValuePickBaseButton({
    required this.title,
    this.onTap,
    EdgeInsets? padding,
  }) : padding = padding ?? EdgeInsets.all(8.toFigmaSize);

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
