part of '../admin_page.dart';

class ClubAdminController {
  final String clubId;
  final ClubApiService apiService;
  final String currentUserId;
  final VoidCallback onUpdate;
  final String clubName;
  final String description;
  final List<Map<String, dynamic>> approvement;

  final ScrollController scrollController = ScrollController();
  final int _pageSize = 30;

  int _currentPage = 0;
  bool isLoading = true;
  bool isLoadingMore = false;
  bool hasMore = true;

  List<UserEntity> users = [];
  List<Map<String, dynamic>> members = [];

  OverlayEntry? _menuOverlay;

  ClubAdminController({
    required this.clubId,
    required this.apiService,
    required this.currentUserId,
    required this.onUpdate,
    required this.clubName,
    required this.description,
    required this.approvement,
  });

  void init() {
    fetchMembers(page: 0);
    scrollController.addListener(_onScroll);
  }

  void dispose() {
    scrollController.dispose();
    _menuOverlay?.remove();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      loadMore();
    }
  }

  void loadMore() {
    if (isLoadingMore || !hasMore) return;
    isLoadingMore = true;
    onUpdate();
    fetchMembers(page: _currentPage + 1);
  }

  String getUserRole(String userId) {
    final member = members.firstWhere((m) => m['id'] == userId, orElse: () => {});
    return member['role'] ?? 'USER';
  }

  Future<void> fetchMembers({int page = 0}) async {
    if (!hasMore && page != 0) return;

    try {
      final newMembers = await getClubMembers(
        clubId: clubId,
        page: page,
        size: _pageSize,
        apiService: apiService,
      );

      final ids = newMembers.map((m) => m['id'] as String).toList();
      final result = await UsersDataSource().getUsers(PageQueryModel(page: 0, size: ids.length), ids);
      final newUsers = result.content.map((u) => u.toDomain()).toList();

      if (page == 0) {
        members = newMembers;
        users = newUsers;
        isLoading = false;
      } else {
        members.addAll(newMembers);
        users.addAll(newUsers);
        isLoadingMore = false;
      }
      _currentPage = page;
      hasMore = newMembers.length == _pageSize;
      onUpdate();      
    } catch (e) {
      print('Ошибка при загрузке участников: $e');
      isLoading = false;
      isLoadingMore = false;
    }
  }

  void showMenuClub(BuildContext context, double dy) {
    late final OverlayEntry overlay;
      overlay = OverlayEntry(
        builder: (_) => TapRegion(
          onTapOutside: (_) {
            overlay.remove();
            overlay.dispose();
          },
          child: ClubAdminMenu(
            dY: dy,
            closeMenu: () {
              overlay.remove();
              overlay.dispose();
            },
            onEdit: () {
              debugPrint('Edit tapped');
              overlay.remove();
              overlay.dispose();
            },
            onDelete: () async {
              await removeClub(clubId: clubId, apiService: apiService);
              overlay.remove();
              overlay.dispose();
              Navigator.of(context).pop();
            },
            clubId: clubId,
            apiService: apiService,
            title:clubName,
            description: description,
            approvement: approvement,
          ),
        ),
      );
    Overlay.of(context).insert(overlay);
  }

  void showMemberMenu(BuildContext context, Offset offset, UserEntity user) {
    _hideMenu();

    final role = getUserRole(user.id);
    final overlay = Overlay.of(context);
    _menuOverlay = OverlayEntry(
      builder: (context) => MemberRoleMenu(
        dY: offset.dy,
        closeMenu: _hideMenu,
        onMakeAdmin: () => roleChangeMember(context, user.id, 'ADMIN'),
        onMakeInspector: () => roleChangeMember(context, user.id, 'INSPECTOR'),
        onMakeMember: () => roleChangeMember(context, user.id, 'USER'),
        onRemoveFromGroup: () => removeMember(context, user.id),
        currentRole: role,
      ),
    );
    overlay.insert(_menuOverlay!);
  }

  void _hideMenu() {
    _menuOverlay?.remove();
    _menuOverlay = null;
  }

  Future<void> roleChangeMember(BuildContext context, String userId, String newRole) async {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmActionDialog(
          message: 'Вы уверены, что хотите изменить роль?',
          confirmText: 'Изменить',
          onConfirm: () async {
            try {
              final result = await changeMemberRole(
                clubId: clubId,
                memberId: userId,
                role: newRole,
                apiService: apiService,
              );

              if (result != null && result['changeMemberRole'] != null) {
                final updatedRole = result['changeMemberRole']['role'];
                final index = members.indexWhere((m) => m['id'] == userId);
                if (index != -1) {
                  members[index]['role'] = updatedRole;
                }
                onUpdate();
              }
            } catch (e) {
              print('Ошибка при изменении роли: $e');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Не удалось изменить роль')),
              );
            }
          },
        );
      },
    );
    _hideMenu();
  }

  void removeMember(BuildContext context, String userId) async {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmActionDialog(
          message: 'Вы уверены, что хотите удалить участника из группы?',
          confirmText: 'Удалить',
          customColor: const Color(0xFFFF281A),
          onConfirm: () async {
            try {
              await removeMemberFromClub(
                clubId: clubId,
                memberId: userId,
                apiService: apiService,
              );
              users.removeWhere((u) => u.id == userId);
              members.removeWhere((m) => m['id'] == userId);
              onUpdate();
            } catch (e) {
              print('Ошибка при удалении: $e');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Не удалось удалить участника')),
              );
            }
          },
        );
      },
    );
    _hideMenu();
  }
}
