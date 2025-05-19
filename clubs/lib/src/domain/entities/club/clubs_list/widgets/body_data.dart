part of '../page.dart';

class ClubsBody extends StatefulWidget {
  final String currentUserId;
  final bool isSearching;

  const ClubsBody({
    super.key, 
    required this.currentUserId,
    this.isSearching = false,
  });

  @override
  State<ClubsBody> createState() => _ClubsBodyState();
}

class _ClubsBodyState extends State<ClubsBody> {
  int _selectedFilterIndex = 0;
  final ScrollController _scrollController = ScrollController();

  List<ClubModel> _filtered(List<ClubModel> groups) {
    switch (_selectedFilterIndex) {
      case 1:
        return groups.where((g) => ['ADMIN', 'INSPECTOR'].contains(g.userRole)).toList();
      case 2:
        return groups.where((g) =>  g.userRole == 'PENDING_APPROVAL').toList();
      default:
        return groups;
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (widget.isSearching && 
          _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
        context.read<ClubsListBloc>().add(LoadNextSearchPageEvent());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClubsListBloc>();

    return RefreshIndicator.adaptive(
      onRefresh: () async => bloc.add(LoadClubsEvent()),
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          if (!widget.isSearching) ...[
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
          ],
          BlocBuilder<ClubsListBloc, ClubsState>(
            builder: (context, state) {
              return switch (state) {
                ClubsLoading() => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator.adaptive()),
                ),
                ClubsLoaded(:final groups) => _filtered(
                        groups.map<ClubModel>((g) => widget.isSearching
                                    ? ClubModel.fromSearchResult(g)
                                    : ClubModel.fromUserClub(g)).toList(),
                              ).isEmpty
                    ? SliverFillRemaining(
                        child: Center(
                          child: Text('Пусто', style: context.textTheme.h4),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final clubModels = groups.map<ClubModel>((g) => widget.isSearching
                                ? ClubModel.fromSearchResult(g)
                                : ClubModel.fromUserClub(g)).toList();
                            final group = widget.isSearching
                                ? clubModels[index]
                                : _filtered(clubModels)[index];

                            return ClubWidget(
                              title: group.name,
                              subscribers: formatMemberCount(group.membersCount),
                              onTap: () async {
                                final clubId = group.id;
                                final role = group.userRole;

                                //if (role == 'ADMIN') {
                                if (role == 'ADMIN') {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ClubAdminScreen(
                                        clubId: clubId,
                                        currentId: widget.currentUserId,
                                        membersCount: group.membersCount,
                                      ),
                                    ),
                                  );
                                  if (result == true) {
                                    bloc.add(LoadClubsEvent());
                                  }
                                } //else if (role == 'NOTMEMBER') {
                                  else if (role == 'NOT_MEMBER') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => NotMemberPage(
                                        clubId: clubId,
                                        currentId: widget.currentUserId,
                                        membersCount: group.membersCount,
                                      ),
                                    ),
                                  );
                                } //else if (role == 'MEMBER') {
                                  else if (role == 'MEMBER') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => MemberPage(
                                        clubId: clubId,
                                        currentId: widget.currentUserId,
                                        membersCount: group.membersCount,
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                          childCount: widget.isSearching
                              ? groups.length
                              : _filtered(groups.map<ClubModel>((g) => ClubModel.fromUserClub(g)).toList()).length,
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
