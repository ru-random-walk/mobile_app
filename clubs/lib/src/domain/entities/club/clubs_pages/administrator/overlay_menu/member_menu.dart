part of '../admin_page.dart';

class MemberRoleMenu extends StatelessWidget {
  final double dY;
  final VoidCallback closeMenu;
  final VoidCallback onMakeAdmin;
  final VoidCallback onMakeInspector;
  final VoidCallback onMakeMember;
  final VoidCallback onRemoveFromGroup;

  const MemberRoleMenu({
    super.key,
    required this.dY,
    required this.closeMenu,
    required this.onMakeAdmin,
    required this.onMakeInspector,
    required this.onMakeMember,
    required this.onRemoveFromGroup,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: closeMenu,
              behavior: HitTestBehavior.translucent,
            ),
          ),
          CustomSingleChildLayout(
            delegate: _MenuLayoutDelegate(dY),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xF2EAEAEA),
                borderRadius: BorderRadius.circular(6.toFigmaSize),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.toFigmaSize),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildItem(
                      context,
                      text: 'Сделать администратором',
                      onTap: () {
                        closeMenu();
                        onMakeAdmin();
                      },
                    ),
                    _divider(context),
                    _buildItem(
                      context,
                      text: 'Сделать инспектором',
                      onTap: () {
                        closeMenu();
                        onMakeInspector();
                      },
                    ),
                    _divider(context),
                    _buildItem(
                      context,
                      text: 'Сделать участником',
                      onTap: () {
                        closeMenu();
                        onMakeMember();
                      },
                    ),
                    _divider(context),
                    _buildItem(
                      context,
                      text: 'Удалить из группы',
                      textColor: const Color(0xFFED0005),
                      onTap: () {
                        closeMenu();
                        onRemoveFromGroup();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );  
  }

  Widget _buildItem(BuildContext context, {
    required String text,
    String? iconPath,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return RowMenuWidget(
      text: text,
      imagePath: iconPath,
      onTap: onTap,
      width: 260.toFigmaSize,
      textColor: textColor,
    );
  }

  Widget _divider(BuildContext context) {
    return SizedBox(
      width: 252.toFigmaSize,
      height: 1.toFigmaSize,
      child: ColoredBox(
        color: context.colors.base_10,
      ),
    );
  }
}
