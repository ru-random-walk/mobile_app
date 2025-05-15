part of '../admin_page.dart';

class MemberTile extends StatelessWidget {
  final String name;
  final String role;
  final String avatarPath;
  final void Function(Offset position)? onMenuPressed;

  const MemberTile({
    super.key,
    required this.name,
    required this.role,
    required this.avatarPath,
    this.onMenuPressed,
  });

  Widget _defaultAvatar() {
    return Image.asset(
      'packages/clubs/assets/images/avatar.png',
      width: 48.toFigmaSize,
      height: 48.toFigmaSize,
      fit: BoxFit.cover,
    );
  }

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
              ClipOval(
                child: avatarPath.isNotEmpty
                  ? Image.network(
                      avatarPath,
                      width: 48.toFigmaSize,
                      height: 48.toFigmaSize,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _defaultAvatar(); 
                      },
                    )
                  : _defaultAvatar(),
              ),
              SizedBox(width: 16.toFigmaSize),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
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
              if (onMenuPressed != null)...[
                IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    size: 28.toFigmaSize, 
                    color: context.colors.base_60,
                  ),
                  onPressed: () {
                    final renderBox = context.findRenderObject();
                    final overlay = Overlay.of(context);

                    if (renderBox is RenderBox && overlay?.context.findRenderObject() is RenderBox) {
                      final overlayBox = overlay!.context.findRenderObject() as RenderBox;
                      final position = renderBox.localToGlobal(Offset.zero, ancestor: overlayBox);
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
