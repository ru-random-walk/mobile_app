part of '../admin_page.dart';

class MemberTile extends StatelessWidget {
  final UserEntity user;
  final String role;
  final void Function(Offset position)? onMenuPressed;

  const MemberTile({
    super.key,
    required this.user,
    required this.role,
    this.onMenuPressed,
  });

  String getRoleLabel(String role) {
    switch (role) {
      case 'ADMIN':
        return 'Администратор';
      case 'USER':
        return 'Участник';
      case 'INSPECTOR':
        return 'Инспектор';
      default:
        return 'Участник';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.toFigmaSize),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AvatarUserWidget(
                user: user,
                size: 48.toFigmaSize,
              ),
              SizedBox(width: 16.toFigmaSize),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: context.textTheme.bodyLRegular.copyWith(
                        color: context.colors.base_90,
                      ),
                    ),
                    Text(
                      getRoleLabel(role),
                      style: context.textTheme.bodySRegular.copyWith(
                        color: context.colors.base_50,
                      ),
                    ),
                  ],
                ),
              ),
              if (onMenuPressed != null) ...[
                IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    size: 28.toFigmaSize,
                    color: context.colors.base_60,
                  ),
                  onPressed: () {
                    final renderBox = context.findRenderObject();
                    final overlay = Overlay.of(context);

                    if (renderBox is RenderBox &&
                        overlay.context.findRenderObject() is RenderBox) {
                      final overlayBox =
                          overlay.context.findRenderObject() as RenderBox;
                      final position = renderBox.localToGlobal(Offset.zero,
                          ancestor: overlayBox);
                      onMenuPressed?.call(position);
                    } else {
                      debugPrint('RenderBox not ready yet');
                    }
                  },
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: context.colors.base_20,
          height: 1.toFigmaSize,
        ),
      ],
    );
  }
}
