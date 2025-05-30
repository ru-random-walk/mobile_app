part of '../page.dart';

class _AddAvailableTimeButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _AddAvailableTimeButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Готово',
      onPressed: onTap,
    );
  }
}
