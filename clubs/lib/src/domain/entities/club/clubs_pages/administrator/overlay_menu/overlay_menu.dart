part of '../admin_page.dart';

class ClubAdminMenu extends StatelessWidget {
  final double dY;
  final VoidCallback closeMenu;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final String clubId;
  final ClubApiService apiService;


  const ClubAdminMenu({
    super.key, 
    required this.dY,
    required this.closeMenu,
    required this.onEdit,
    required this.onDelete,
    required this.clubId,
    required this.apiService,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: CustomSingleChildLayout(
        delegate: _MenuLayoutDelegate(dY),
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
                      onTap:() {},
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
                      onTap: () async {
                        try {
                          // Пытаемся выполнить удаление
                          final result = await removeClub(clubId: clubId, apiService: apiService);
                          
                          // Если удаление прошло успешно
                          closeMenu();
                          Navigator.of(context).pop(); // Возвращаем назад
                          
                          // Показываем SnackBar с успешным сообщением
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Клуб удален успешно!', style: context.textTheme.bodySMediumBase0),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } catch (e) {
                          // В случае ошибки
                          closeMenu();
                          
                          // Показываем SnackBar с ошибкой
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Ошибка при удалении клуба: ${e.toString()}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
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

class _MenuLayoutDelegate extends SingleChildLayoutDelegate {
  final double dY;

  const _MenuLayoutDelegate(this.dY);

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(
        Size(constraints.maxWidth, constraints.maxHeight));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final dx = size.width - 10.toFigmaSize - childSize.width;
    return Offset(dx, dY);
  }

  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) => false;
}
