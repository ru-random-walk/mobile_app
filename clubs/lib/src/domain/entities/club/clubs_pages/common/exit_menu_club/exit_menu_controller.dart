import 'package:clubs/src/data/clubs_api_service.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/overlay_menu_position.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/row_menu.dart';
import 'package:flutter/material.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/alert_dialogs.dart';
import 'package:clubs/utils/qraphql_error_utils.dart';
import 'package:ui_utils/ui_utils.dart';

part 'exit_overlay_menu.dart';

class ExitMenuController {
  final BuildContext context;
  final String clubId;
  final String userId;
  final ClubApiService apiService;
  final VoidCallback onLeaveSuccess;

  OverlayEntry? _menuOverlay;

  ExitMenuController({
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
        child: ExitOverlayMenu(
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