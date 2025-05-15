part of '../admin_page.dart';

class RowMenuWidget extends StatelessWidget {
  final String text;
  final String? imagePath;
  final VoidCallback onTap;
  final double? width;
  final Color? textColor;

  const RowMenuWidget({
    super.key, 
    required this.text,
    this.imagePath,
    required this.onTap,
    this.width,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final w = width ?? 200.toFigmaSize;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 40.toFigmaSize,
        width: w,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (imagePath != null) ...[
                SvgPicture.asset(
                  imagePath!,
                  package: 'clubs',
                  width: 24.toFigmaSize,
                  height: 24.toFigmaSize,
                  colorFilter: ColorFilter.mode(
                    textColor ?? context.colors.base_50,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 8.toFigmaSize),
              ],
              Text(
                text,
                style: context.textTheme.bodyMRegularBase70.copyWith(
                  color: textColor ?? context.colors.base_70, 
                ),
                textAlign: TextAlign.center, 
                overflow: TextOverflow.ellipsis, 
              ),
            ],
          ),
        ),
      ),
    );
  }
}
