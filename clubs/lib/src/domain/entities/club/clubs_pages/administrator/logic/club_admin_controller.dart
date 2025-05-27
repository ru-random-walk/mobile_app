part of '../admin_page.dart';

class ClubAdminController {
  final String clubId;
  final ClubApiService apiService;
  final String currentUserId;
  final VoidCallback onUpdate;
  final String clubName;
  final int? photoVersion;
  final String description;
  final List<Map<String, dynamic>> approvement;

  int inspectorAndAdminCount = 0;

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
    required this.photoVersion,
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
    final member =
        members.firstWhere((m) => m['id'] == userId, orElse: () => {});
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
      final result = await UsersDataSource()
          .getUsers(PageQueryModel(page: 0, size: ids.length), ids);
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
      _countRoles();
      _currentPage = page;
      hasMore = newMembers.length == _pageSize;
      onUpdate();
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка при загрузке участников: $e');
      }
      isLoading = false;
      isLoadingMore = false;
    }
  }

  void _countRoles() {
    inspectorAndAdminCount = members
        .where((m) => m['role'] == 'ADMIN' || m['role'] == 'INSPECTOR')
        .length;
  }

  void showMenuClub(BuildContext context, double dy) {
    _hideMenu();

    Overlay.of(context);

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
          onEdit: () async {
            try {
              final navigator = Navigator.of(context);
              final clubData = await getApprovementInfo(
                clubId: clubId,
                apiService: apiService,
              );

              if (context.mounted &&
                  handleGraphQLErrors(
                    context,
                    clubData,
                    fallbackMessage: 'Ошибка при загрузке редактирования',
                  )) {
                return;
              }

              final approvements = clubData?['data']?['getClub']
                  ?['approvements'] as List<dynamic>?;

              if (approvements == null || approvements.isEmpty) {
                navigator.push(
                  MaterialPageRoute(
                    builder: (context) => ClubFormScreen(
                      initialName: clubName,
                      initialDescription: description,
                      inspectorAndAdminCount: inspectorAndAdminCount,
                      initialIsConditionAdded: false,
                      isEditMode: true,
                      clubId: clubId,
                    ),
                  ),
                );
                return;
              }

              final data = approvements.first['data'];
              final typename = data['__typename'];

              String conditionName = '';
              int infoCount = 0;
              List<Map<String, dynamic>>? questions;
              String approvementId = approvements.first['id'];

              if (typename == 'FormApprovementData') {
                conditionName = 'Тест';
                questions = (data['questions'] as List<dynamic>?)
                    ?.map((q) => Map<String, dynamic>.from(q))
                    .toList();
                infoCount = questions?.length ?? 0;
              } else if (typename == 'MembersConfirmApprovementData') {
                conditionName = 'Запрос на вступление';
                infoCount = data['requiredConfirmationNumber'];
              }

              navigator.push(
                MaterialPageRoute(
                  builder: (context) => ClubFormScreen(
                    initialName: clubName,
                    initialDescription: description,
                    initialIsConditionAdded: true,
                    initialConditionName: conditionName,
                    initialInfoCount: infoCount,
                    initialQuestions: questions,
                    inspectorAndAdminCount: inspectorAndAdminCount,
                    isEditMode: true,
                    clubId: clubId,
                    approvementId: approvementId,
                    photoVersion: photoVersion,
                  ),
                ),
              );
            } catch (e) {
              if (kDebugMode) {
                print(e);
              }
              if (context.mounted) {
                showErrorSnackbar(context, 'Произошла ошибка');
              }
            }
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
                      final navigator = Navigator.of(context);
                      final result = await removeClub(
                          clubId: clubId, apiService: apiService);

                      if (context.mounted &&
                          handleGraphQLErrors(context, result,
                              fallbackMessage: 'Ошибка при удалении группы')) {
                        return;
                      }

                      navigator.pop(true);
                    } catch (e) {
                      if (context.mounted) {
                        showErrorSnackbar(context, 'Произошла ошибка');
                      }
                    }
                  },
                );
              },
            );

            if (confirmed == true && context.mounted) {
              _hideMenu();
              Navigator.of(context).pop(true);
            }
          },
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

  Future<void> roleChangeMember(
      BuildContext context, String userId, String newRole) async {
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

              if (context.mounted &&
                  handleGraphQLErrors(context, result,
                      fallbackMessage: 'Не удалось изменить роль')) {
                return;
              }

              final updatedRole = result?['data']?['changeMemberRole']?['role'];
              if (updatedRole != null) {
                final index = members.indexWhere((m) => m['id'] == userId);
                if (index != -1) {
                  members[index]['role'] = updatedRole;
                }
                onUpdate();
              } else if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Роль не была обновлена')),
                );
              }
            } catch (e) {
              if (context.mounted) {
                showErrorSnackbar(context, 'Произошла ошибка');
              }
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

              if (context.mounted &&
                  handleGraphQLErrors(context, result,
                      fallbackMessage: 'Не удалось удалить участника')) {
                return;
              }

              users.removeWhere((u) => u.id == userId);
              members.removeWhere((m) => m['id'] == userId);
              onUpdate();
            } catch (e) {
              if (context.mounted) {
                showErrorSnackbar(context, 'Произошла ошибка');
              }
            }
          },
        );
      },
    );
    _hideMenu();
  }
}
