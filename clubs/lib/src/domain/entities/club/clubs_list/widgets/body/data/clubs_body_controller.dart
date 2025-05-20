part of '../../../page.dart';

class ClubsBodyController {
  late ScrollController scrollController;
  int selectedFilterIndex = 0;
  late ClubsBody widget;
  late BuildContext context;
  

  void init(ClubsBody widget, BuildContext context) {
    this.widget = widget;
    this.context = context;
    scrollController = ScrollController();

    scrollController.addListener(() {
      if (widget.isSearching &&
          scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {
        context.read<ClubsListBloc>().add(LoadNextSearchPageEvent());
      }
    });
  }

  void dispose() {
    scrollController.dispose();
  }

  List<ClubModel> filterClubs(List<ClubModel> groups) {
    switch (selectedFilterIndex) {
      case 1:
        return groups.where((g) => ['ADMIN', 'INSPECTOR'].contains(g.userRole)).toList();
      case 2:
        return groups.where((g) => g.userRole == 'PENDING_APPROVAL').toList();
      default:
        return groups;
    }
  }

  Widget buildWith({
    required BuildContext context,
    required Function(int index) onFilterChanged,
    VoidCallback? onFindGroup,
  }) {
    final bloc = context.read<ClubsListBloc>();

    return RefreshIndicator.adaptive(
      onRefresh: () async => bloc.add(LoadClubsEvent()),
      child: CustomScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          if (!widget.isSearching)
            SliverToBoxAdapter(
              child: ClubFiltersSection(
                selectedIndex: selectedFilterIndex,
                onFilterChanged: onFilterChanged,
              ),
            ),
          ClubListView(
            isSearching: widget.isSearching,
            widget: widget,
            filterClubs: filterClubs,
            onFindGroup: onFindGroup,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
        ],
      ),
    );
  }
}
