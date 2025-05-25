part of '../../page.dart';

class _BaseMapInterfaceButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsets? padding;

  const _BaseMapInterfaceButton({
    this.onPressed,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onPressed,
      type: ButtonType.secondary,
      size: ButtonSize.S,
      color: ButtonColor.grey,
      text: null,
      rightIcon: child,
      isMaxWidth: false,
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: 16.toFigmaSize,
            horizontal: 18.toFigmaSize,
          ),
      customWidth: 52.toFigmaSize,
      customHeight: 48.toFigmaSize,
      secondaryStyleFillColor: context.colors.base_0,
    );
  }
}
