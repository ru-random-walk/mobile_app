part of '../page.dart';

class ClubsScreen extends StatefulWidget {
  final String currentUserId;

  const ClubsScreen({super.key, required this.currentUserId});

  @override
  State<ClubsScreen> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
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

  String formatMemberCount(int count) {
    final mod10 = count % 10;
    final mod100 = count % 100;

    String suffix;
    if (mod100 >= 11 && mod100 <= 14) {
      suffix = 'участников';
    } else if (mod10 == 1) {
      suffix = 'участник';
    } else if (mod10 >= 2 && mod10 <= 4) {
      suffix = 'участника';
    } else {
      suffix = 'участников';
    }

    return '$count $suffix';
  }
      
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClubsListBloc>();

    return Scaffold(
      appBar: _ClubsListAppBar(),
      floatingActionButton: AddClubButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClubFormScreen(),
            ),
          );
          if (result == true) {
            context.read<ClubsListBloc>().add(LoadClubsEvent());
          }
        },
      ),
      body: RefreshIndicator.adaptive(
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
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                  ClubsLoaded(:final groups) => 
                    _filtered(groups).isEmpty
                      ? SliverFillRemaining(
                          child: Center(
                            child: Text(
                              'Пусто',
                              style: context.textTheme.h4,
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final group = _filtered(groups)[index];
                              final role = group['userRole'];
                              final club = group['club'];
                              return ClubWidget(
                                title: group['club']?['name'] ?? '',
                                subscribers: formatMemberCount((group['club']?['members'] as List?)?.length ?? 0),
                                onTap: () {
                                  if (role == 'ADMIN') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ClubAdminScreen(club: club),
                                      ),
                                    );
                                  } }
                              );
                            },
                            childCount: _filtered(groups).length,
                          ),
                        ),
                  ClubsError() => SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'Ошибка загрузки групп',
                        style: context.textTheme.h4,
                      ),
                    ),
                  ),
                  _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
                };
              },
            ),
            SliverToBoxAdapter(child: SizedBox(height: 8.toFigmaSize)),
          ],
        ),
      ),
    );
  }
}
