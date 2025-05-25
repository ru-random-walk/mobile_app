part of '../page.dart';

class _EditableBlockWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final int maxLines;

  const _EditableBlockWidget({
    required this.title,
    required this.controller,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.bodyXLMedium.copyWith(
            color: context.colors.base_90,
          ),
        ),
        SizedBox(height: 8.toFigmaSize),
        TextField(
          minLines: 1,
          onTapOutside: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          maxLines: maxLines,
          controller: controller,
          decoration: InputDecoration(
            isDense: true,
            fillColor: context.colors.base_0,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.toFigmaSize),
              borderSide: BorderSide(
                color: context.colors.main_70,
                width: 1.toFigmaSize,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.toFigmaSize),
              borderSide: BorderSide(
                color: context.colors.base_20,
                width: 1.toFigmaSize,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
