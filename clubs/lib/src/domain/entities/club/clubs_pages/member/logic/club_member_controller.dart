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
              final result = await removeMemberFromClub(
                clubId: clubId,
                memberId: userId,
                apiService: apiService,
              );

              if (handleGraphQLErrors(context, result, fallbackMessage: 'Ошибка при выходе из группы')) return;

              Navigator.of(context).pop(); 
            } catch (e) {
              print('Ошибка при выходе из группы: $e');
              showErrorSnackbar(context, 'Ошибка при выходе из группы');
            }
          },
        );
      },
    );
    _closeMenu();
  }
}