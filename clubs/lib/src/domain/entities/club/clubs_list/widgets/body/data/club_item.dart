part of '../../../page.dart';

class ClubItemTile extends StatelessWidget {
  final ClubModel group;
  final String currentUserId;

  const ClubItemTile({
    super.key,
    required this.group,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return ClubWidget(
      title: group.name,
      subscribers: formatMemberCount(group.membersCount),
      onTap: () async {
        final clubId = group.id;
        final role = group.userRole;

        if (role == 'ADMIN') {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ClubAdminScreen(
                clubId: clubId,
                currentId: currentUserId,
                membersCount: group.membersCount,
              ),
            ),
          );
          if (result == true) {
            context.read<ClubsListBloc>().add(LoadClubsEvent());
          }
        } else if (role == 'NOT_MEMBER') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NotMemberPage(
                clubId: clubId,
                currentId: currentUserId,
                membersCount: group.membersCount,
              ),
            ),
          );
        } else if (role == 'MEMBER') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MemberPage(
                clubId: clubId,
                currentId: currentUserId,
                membersCount: group.membersCount,
              ),
            ),
          );
        }
      },
    );
  }
}
