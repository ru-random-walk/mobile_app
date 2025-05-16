part of '../page.dart';

class ClubsBody extends StatefulWidget {
  final String currentUserId;

  const ClubsBody({super.key, required this.currentUserId});

  @override
  State<ClubsBody> createState() => _ClubsBodyState();
}

class _ClubsBodyState extends State<ClubsBody> {
  int _selectedFilterIndex = 0;

  List<Map<String, dynamic>> _filtered(List<Map<String, dynamic>> groups) {
    switch (_selectedFilterIndex) {
      case 1:
        return groups.where((g) => ['ADMIN', 'INSPECTOR'].contains(g['userRole'])).toList();
      case 2:
        return groups.where((g) => g['userRole'] == 'PENDING_APPROVAL').toList();
      default:
        return groups;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClubsListBloc>();

    return RefreshIndicator.adaptive(
      onRefresh: () async => bloc.add(LoadClubsEvent()),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 8.toFigmaSize),
                GroupFilters(
                  selectedIndex: _selectedFilterIndex,
                  onFilterChanged: (index) {
                    setState(() {
                      _selectedFilterIndex = index;
                    });
                  },
                ),
                SizedBox(height: 8.toFigmaSize),
              ],
            ),
          ),
          BlocBuilder<ClubsListBloc, ClubsState>(
            builder: (context, state) {
              return switch (state) {
                ClubsLoading() => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator.adaptive()),
                ),
                ClubsLoaded(:final groups) => _filtered(groups).isEmpty
                    ? SliverFillRemaining(
                        child: Center(
                          child: Text('Пусто', style: context.textTheme.h4),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final group = _filtered(groups)[index];
                            final role = group['userRole'];
                            final membersCount = (group['club']?['members'] as List).length;
                            return ClubWidget(
                              title: group['club']?['name'] ?? '',
                              subscribers: formatMemberCount(membersCount),
                              onTap: () {
                                final clubId = group['club']?['id'];

                                //if (role == 'ADMIN') {
                                if (role == 'USER') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ClubAdminScreen(
                                        clubId: clubId,
                                        currentId: widget.currentUserId,
                                        membersCount: membersCount,
                                      ),
                                    ),
                                  );
                                } //else if (role == 'ADMIN' || role == 'MEMBER') {
                                  else if (role == 'NOTMEMBER') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => NotMemberPage(
                                        clubId: clubId,
                                        currentId: widget.currentUserId,
                                        membersCount: membersCount,
                                      ),
                                    ),
                                  );
                                } else if (role == 'ADMIN') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => MemberPage(
                                        clubId: clubId,
                                        currentId: widget.currentUserId,
                                        membersCount: membersCount,
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                          childCount: _filtered(groups).length,
                        ),
                      ),
                ClubsError() => SliverFillRemaining(
                  child: Center(
                    child: Text('Ошибка загрузки групп', style: context.textTheme.h4),
                  ),
                ),
                _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
              };
            },
          ),
          SliverToBoxAdapter(child: SizedBox(height: 8.toFigmaSize)),
        ],
      ),
    );
  }
}
