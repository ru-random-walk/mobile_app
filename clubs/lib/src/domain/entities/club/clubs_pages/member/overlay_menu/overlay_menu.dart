part of '../member_page.dart';

class ClubMemberMenu extends StatelessWidget {
  final double dY;
  final VoidCallback closeMenu;
  final VoidCallback onLeave;
  final ClubApiService apiService;
  final String clubId;
  final String userId;

  const ClubMemberMenu({
    super.key,
    required this.dY,
    required this.closeMenu,
    required this.onLeave,
    required this.apiService,
    required this.clubId,
    required this.userId,
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
                          text: 'Выйти из группы',
                          textColor: const Color(0xFFED0005),
                          onTap: () {
                            closeMenu();
                            onLeave();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
