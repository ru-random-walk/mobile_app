part of '../admin_page.dart';

class RowMenuWidget extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onTap;

  const RowMenuWidget({
    super.key, 
    required this.text,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 40.toFigmaSize,
        width: 200.toFigmaSize,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                imagePath,
                package: 'clubs',
                width: 24.toFigmaSize,
                height: 24.toFigmaSize,
                colorFilter: ColorFilter.mode(
                  context.colors.base_50,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(
                width: 8.toFigmaSize,
              ),
              Text(
                text,
                style: context.textTheme.bodyMRegularBase70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
