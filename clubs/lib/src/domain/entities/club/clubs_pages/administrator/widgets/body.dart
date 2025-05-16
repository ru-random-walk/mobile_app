part of '../admin_page.dart';

class ClubAdminBody extends StatefulWidget {
  final String title;
  final String description;
  final List<Map<String, dynamic>> approvement;
  final String clubId;
  final ClubApiService apiService;
  final String currentUserId;

  const ClubAdminBody({
    super.key,
    required this.title,
    required this.description,
    required this.approvement,
    required this.clubId,
    required this.apiService,
    required this.currentUserId,
  });

  @override
  State<ClubAdminBody> createState() => _ClubAdminBodyState();
}

class _ClubAdminBodyState extends State<ClubAdminBody> {
  late final ClubAdminController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ClubAdminController(
      clubId: widget.clubId,
      apiService: widget.apiService,
      currentUserId: widget.currentUserId,
      onUpdate: () => setState(() {}),
    )..init();
  }

  @override
  void dispose() {
     _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final itemCount = _controller.users.length + 1 + (_controller.isLoadingMore ? 1 : 0);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 4.toFigmaSize,
        horizontal: 20.toFigmaSize,
      ),
      child: ListView.builder(
        controller: _controller.scrollController,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ClubHeader(
              title: widget.title,
              description: widget.description,
              approvement: widget.approvement,
              membersCount: _controller.members.length,
            );
          }
          if (_controller.isLoadingMore && index == itemCount - 1) {
            return const Center(child: CircularProgressIndicator());
          }
          final user = _controller.users[index-1];
          final role = _controller.getUserRole(user.id);
          return MemberTile(
            name: user.fullName,
            role: role,
            avatarPath: user.avatar,
            //onMenuPressed: user.id == widget.currentUserId ? null : (Offset position) {
            onMenuPressed: (Offset position) {
              _controller.showMemberMenu(context, position, user);
            },
          );
        },
      ),
    );
  }
}
