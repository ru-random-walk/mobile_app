part of '../../../page.dart';

class _MeetDataRowWidget extends StatelessWidget {
  final String title;
  final Widget button;

  const _MeetDataRowWidget({
    super.key,
    required this.title,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280.toFigmaSize,
      child: Padding(
        padding: EdgeInsets.all(
          4.toFigmaSize,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title:',
              style: context.textTheme.bodyMRegularBase90,
            ),
            button,
          ],
        ),
      ),
    );
  }
}
