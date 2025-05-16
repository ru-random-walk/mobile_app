part of '../member_page.dart';

class ClubMemberMenuController {
  final BuildContext context;
  final String clubId;
  final String userId;
  final ClubApiService apiService;
  final VoidCallback onLeaveSuccess;

  OverlayEntry? _menuOverlay;

  ClubMemberMenuController({
    required this.context,
    required this.clubId,
    required this.userId,
    required this.apiService,
    required this.onLeaveSuccess,
  });

  void _closeMenu() {
    _menuOverlay?.remove();
    _menuOverlay = null;
  }

  void showMenu(double dy) {
    _closeMenu();
    _menuOverlay = OverlayEntry(
      builder: (_) => TapRegion(
        onTapOutside: (_) {
          _closeMenu();
        },
        child: ClubMemberMenu(
          dY: dy,
          closeMenu: _closeMenu,
          onLeave: _onLeaveGroup,
          apiService: apiService,
          clubId: clubId,
          userId: userId,
        ),
      ),
    );
    Overlay.of(context).insert(_menuOverlay!);
  }

  Future<void> _onLeaveGroup() async {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmActionDialog(
          message: 'Вы уверены, что хотите выйти из группы?',
          confirmText: 'Выйти',
          customColor: const Color(0xFFFF281A),
          onConfirm: () async {
            try {
              await removeMemberFromClub(
                clubId: clubId,
                memberId: userId,
                apiService: apiService,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Вы вышли из группы'),
                backgroundColor: context.colors.main_50,),
              );

              Navigator.of(context).pop(); 
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ошибка при выходе из группы')),
              );
            }
          },
        );
      },
    );
    _closeMenu();
  }
}