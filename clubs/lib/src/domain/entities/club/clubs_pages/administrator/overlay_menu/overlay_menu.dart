part of '../admin_page.dart';

class ClubAdminMenu extends StatelessWidget {
  final double dY;
  final VoidCallback closeMenu;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final String title;
  final String description;
  final List<Map<String, dynamic>> approvement;
  final String clubId;
  final ClubApiService apiService;


  const ClubAdminMenu({
    super.key, 
    required this.dY,
    required this.closeMenu,
    required this.onEdit,
    required this.onDelete,
    required this.title,
    required this.description,
    required this.approvement,
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
                      onTap: () async {
                        try {
                          final clubData = await getApprovementInfo(clubId: clubId, apiService: apiService,);

                          final approvements = clubData?['getClub']?['approvements'] as List<dynamic>?;

                          if (approvements == null || approvements.isEmpty) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ClubFormScreen(
                                  initialName: title,
                                  initialDescription: description,
                                  initialIsConditionAdded: false,
                                ),
                              ),
                            );
                            closeMenu();
                            return;
                          }

                          final data = approvements.first['data'];
                          final typename = data['__typename'];

                          String conditionName = '';
                          int infoCount = 0;
                          List<Map<String, dynamic>>? questions; 

                          if (typename == 'FormApprovementData') {
                            conditionName = 'Тест';
                            questions = (data['questions'] as List<dynamic>?)
                              ?.map((q) => Map<String, dynamic>.from(q))
                              .toList();
                            infoCount = questions?.length ?? 0;
                          } else if (typename == 'MembersConfirmApprovementData') {
                            conditionName = 'Запрос на подтверждение';
                            infoCount = data['requiredConfirmationNumber'];
                          }                         

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ClubFormScreen(
                                initialName: title,
                                initialDescription: description,
                                initialIsConditionAdded: true,
                                initialConditionName: conditionName,
                                initialInfoCount: infoCount,
                                initialQuestions: questions,
                              ),
                            ),
                          );
                          closeMenu();
                        }catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Ошибка при получении данных'),
                            ),
                          );
                        }
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
                      onTap: () async {
                        try {
                          final result = await removeClub(clubId: clubId, apiService: apiService);
                          closeMenu();
                          Navigator.of(context).pop(); 
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Клуб удален успешно!', style: context.textTheme.bodySMediumBase0),
                              backgroundColor: context.colors.main_50,
                            ),
                          );
                        } catch (e) {
                          closeMenu();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Ошибка при удалении клуба'),
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
