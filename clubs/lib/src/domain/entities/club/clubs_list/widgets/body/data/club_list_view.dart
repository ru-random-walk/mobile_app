part of '../../../page.dart';

class ClubListView extends StatelessWidget {
  final ClubsBody widget;
  final bool isSearching;
  final List<ClubModel> Function(List<ClubModel>) filterClubs;

  const ClubListView({
    super.key,
    required this.widget,
    required this.isSearching,
    required this.filterClubs,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClubsListBloc, ClubsState>(
      builder: (context, state) {
        return switch (state) {
          ClubsLoading() => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator.adaptive())),
          ClubsLoaded(:final groups) => _buildClubs(groups, context),
          ClubsError() => SliverFillRemaining(
              child: Center(child: Text('Ошибка загрузки групп', style: context.textTheme.h4))),
          _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
        };
      },
    );
  }

  Widget _buildClubs(List<dynamic> groups, BuildContext context) {
    final clubModels = groups.map<ClubModel>((g) => isSearching
        ? ClubModel.fromSearchResult(g)
        : ClubModel.fromUserClub(g)).toList();

    final filtered = isSearching ? clubModels : filterClubs(clubModels);

    if (filtered.isEmpty) {
      return SliverFillRemaining(
        child: Center(child: Text('Пусто', style: context.textTheme.h4)),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ClubItemTile(
          group: filtered[index],
          currentUserId: widget.currentUserId,
        ),
        childCount: filtered.length,
      ),
    );
  }
}
