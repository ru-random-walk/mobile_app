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
      clubId: group.id,
      photoVersion: group.photoVersion,
      title: group.name,
      subscribers: formatMemberCount(group.membersCount),
      onTap: () async {
        final clubId = group.id;
        final role = group.userRole;
        final navigator = Navigator.of(context);
        final bloc = context.read<ClubsListBloc>();

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
            bloc.add(LoadClubsEvent());
          }
        } if (role == 'INSPECTOR') {
          final result = await navigator.push(
            MaterialPageRoute(
              builder: (_) => ClubInspectorScreen(
                clubId: clubId,
                currentId: currentUserId,
                membersCount: group.membersCount,
              ),
            ),
          );
          if (result == true) {
            bloc.add(LoadClubsEvent());
          }
        } else if (role == 'MEMBER' || role == 'USER') {
          navigator.push(
            MaterialPageRoute(
              builder: (_) => MemberPage(
                clubId: clubId,
                currentId: currentUserId,
                membersCount: group.membersCount,
              ),
            ),
          );
        } else if (role == 'PENDING_APPROVAL' || role == 'NOT_MEMBER'){
          navigator.push(
            MaterialPageRoute(
              builder: (_) => NotMemberPage(
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
