part of '../admin_page.dart';

class ClubAdminMenu extends StatelessWidget {
  final double dY;
  final VoidCallback closeMenu;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ClubAdminMenu({
    super.key, 
    required this.dY,
    required this.closeMenu,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: CustomSingleChildLayout(
        delegate: MenuLayoutDelegate(dY),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(
              0xF2EAEAEA,
            ),
            borderRadius: BorderRadius.circular(6.toFigmaSize),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.toFigmaSize),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RowMenuWidget(
                      text: 'Изменить',
                      imagePath: 'assets/icons/edit.svg',
                      onTap: () async {
                        closeMenu();
                        onEdit();
                      },
                    ),
                    SizedBox(
                      width: 200.toFigmaSize,
                      height: 1.toFigmaSize,
                      child: ColoredBox(
                        color: context.colors.base_10,
                      ),
                    ),
                    RowMenuWidget(
                      text: 'Удалить',
                      imagePath: 'assets/icons/delete.svg',
                      onTap: () {
                        closeMenu();
                        onDelete();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
