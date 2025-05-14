part of 'admin_page.dart';

class MemberTile extends StatelessWidget {
  final String name;
  final String role;
  final String avatarPath;
  final VoidCallback? onMenuPressed;

  const MemberTile({
    super.key,
    required this.name,
    required this.role,
    required this.avatarPath,
    this.onMenuPressed,
  });

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
                child: Image.asset(
                  avatarPath,
                  width: 48.toFigmaSize,
                  height: 48.toFigmaSize,
                  fit: BoxFit.cover,
                ),
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
                      role,
                      style: context.textTheme.bodySRegular.copyWith(
                        color: context.colors.base_50,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  size: 32.toFigmaSize, 
                  color: context.colors.base_50,
                ),
                onPressed: onMenuPressed,
                constraints: const BoxConstraints(), 
                padding: EdgeInsets.zero, 
                visualDensity: VisualDensity.compact,
              ),
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
