part of '../admin_page.dart';

class ClubAdminBody extends StatefulWidget {
  final String clubName;
  final String description;
  final List<Map<String, dynamic>> approvement;
  final int membersCount;
  final String clubId;
  final ClubApiService apiService;
  final String currentUserId;
  final ClubAdminController controller;
  final int photoVersion;

  const ClubAdminBody({
    super.key,
    required this.clubName,
    required this.description,
    required this.approvement,
    required this.membersCount,
    required this.clubId,
    required this.apiService,
    required this.currentUserId,
    required this.controller,
    required this.photoVersion,
  });

  @override
  State<ClubAdminBody> createState() => _ClubAdminBodyState();
}

class _ClubAdminBodyState extends State<ClubAdminBody> {
  late final ClubAdminController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final itemCount =
        _controller.users.length + 1 + (_controller.isLoadingMore ? 1 : 0);
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
              title: widget.clubName,
              description: widget.description,
              approvement: widget.approvement,
              membersCount: widget.membersCount,
              approverId: widget.currentUserId,
              clubId: widget.clubId,
              apiService: widget.apiService,
              photoVersion: widget.photoVersion,
            );
          }
          if (_controller.isLoadingMore && index == itemCount - 1) {
            return const Center(child: CircularProgressIndicator());
          }
          final user = _controller.users[index - 1];
          final role = _controller.getUserRole(user.id);
          return MemberTile(
            role: role,
            user: user,
            onMenuPressed: user.id == widget.currentUserId
                ? null
                : (Offset position) {
                    //onMenuPressed: (Offset position) {
                    _controller.showMemberMenu(context, position, user);
                  },
          );
        },
      ),
    );
  }
}
