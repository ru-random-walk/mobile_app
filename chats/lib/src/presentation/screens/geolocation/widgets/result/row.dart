part of '../../page.dart';

class _PickedAddressRow extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const _PickedAddressRow({
    super.key,
    required this.title,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final spacer = SizedBox(width: 16.toFigmaSize);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 4.toFigmaSize,
      ),
      child: Row(
        children: [
          spacer,
          Expanded(
            flex: 60,
            child: Text(
              title,
              style: context.textTheme.bodyMRegularBase90,
            ),
          ),
          spacer,
          Expanded(
            flex: 250,
            child: CustomTextField(
              maxLines: 1,
              radius: 6.toFigmaSize,
              controller: controller,
              height: 32.toFigmaSize,
              hint: title,
            ),
          ),
          spacer,
        ],
      ),
    );
  }
}
