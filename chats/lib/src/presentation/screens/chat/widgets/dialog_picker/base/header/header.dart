part of '../../../../page.dart';

class _DialogPickerHeader extends StatelessWidget {
  const _DialogPickerHeader({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.toFigmaSize),
            child: Center(
              child: Text(
                title,
                style: context.textTheme.h5.copyWith(
                  color: context.colors.base_90,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 4.toFigmaSize,
        ),
        _DialogPickerHeaderCloseButton(),
        SizedBox(
          width: 4.toFigmaSize,
        ),
      ],
    );
  }
}
