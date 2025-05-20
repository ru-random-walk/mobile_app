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
    _menuOverlay = null;
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
    _hideMenu();

    Overlay.of(context);

    final scaffoldContext = context;

     _menuOverlay = OverlayEntry(
        builder: (_) => TapRegion(
          onTapOutside: (_) {
            _hideMenu();
          },
          child: ClubAdminMenu(
            dY: dy,
            closeMenu: () {
              _hideMenu();
            },
            onEdit: () {
              debugPrint('Edit tapped');
              _hideMenu();
            },
            onDelete: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (dialogContext) {
                  return ConfirmActionDialog(
                    message: 'Вы уверены, что хотите удалить группу?',
                    confirmText: 'Удалить',
                    customColor: const Color(0xFFFF281A),
                    onConfirm: () async {
                      try {
                        final result = await removeClub(clubId: clubId, apiService: apiService);
                        
                        if (handleGraphQLErrors(context, result, fallbackMessage: 'Ошибка при удалении группы')) {
                          return;
                        }

                        Navigator.of(context).pop(true); 
                      } catch (e) {
                        showErrorSnackbar(context, 'Произошла ошибка');
                      }
                    },
                  );
                },
              );

              if (confirmed == true) {
                _hideMenu();
                Navigator.of(context).pop(true); 
              }
            },
            clubId: clubId,
            apiService: apiService,
            title:clubName,
            description: description,
            approvement: approvement,
          ),
        ),
      );
    Overlay.of(context).insert(_menuOverlay!);
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

              if (handleGraphQLErrors(context, result, fallbackMessage: 'Не удалось изменить роль')) return;

              final updatedRole = result?['data']?['changeMemberRole']?['role'];
              if (updatedRole != null) {
                final index = members.indexWhere((m) => m['id'] == userId);
                if (index != -1) {
                  members[index]['role'] = updatedRole;
                }
                onUpdate();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Роль не была обновлена')),
                );
              }
            } catch (e) {
              showErrorSnackbar(context, 'Произошла ошибка');
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
              final result = await removeMemberFromClub(
                clubId: clubId,
                memberId: userId,
                apiService: apiService,
              );

              if (handleGraphQLErrors(context, result, fallbackMessage: 'Не удалось удалить участника')) return;

              users.removeWhere((u) => u.id == userId);
              members.removeWhere((m) => m['id'] == userId);
              onUpdate();
            } catch (e) {
              showErrorSnackbar(context, 'Произошла ошибка');
            }
          },
        );
      },
    );
    _hideMenu();
  }
}
